mtype = { 
            // philosophers states
            THINKING, HUNGRY, EATING, 

            // chopstick states
            AVAIL_TO_RIGHT, AVAIL_TO_LEFT, OCCUPIED,

            // message types for philosopher-chopstick communication
            REQ, REL, ACC, DEN
        }      

mtype phil_states[5];
mtype stick_states[5];
chan toStick[5] = [0] of {mtype, byte}
chan toPhil[5] = [0] of {mtype}

inline pick_both_sticks(i) {
    byte left = i;
    byte right = (i + 1) % 5;
    mtype msg_type_left;
    mtype msg_type_right;

    do
    :: toStick[left] ! REQ, i;
       toPhil[i] ? msg_type_left;

       toStick[right] ! REQ, i;
       toPhil[i] ? msg_type_right;

       if
       :: (msg_type_left == ACC && msg_type_right == ACC) ->
            printf("Philosopher %d takes sticks %d and %d\n", i, left, right);
            break;
       :: else ->
            if
            :: msg_type_left == ACC -> toStick[left] ! REL, i;
            :: msg_type_right == ACC -> toStick[right] ! REL, i;
            fi;
       fi
    od
}
inline pick_stick(j, i) {

    // only a neighbor philosoper can pick the stick
    assert(i == j || (j > 0 && i == j - 1) || (j == 0 && i == 4));

    mtype msg_type;
    
    do
    :: toStick[j] ! REQ, i;
       toPhil[i] ? msg_type;
       if
       :: msg_type == ACC ->
            printf("Philosopher %d takes stick %d\n", i, j);
            break;
       :: msg_type == DEN -> skip; // retry
       fi
    od
}

inline release_both_sticks(i) {
    
    byte left = i;
    byte right = (i + 1) % 5;

     atomic {
        toStick[left] ! REL, i;
        toStick[right] ! REL, i;
        printf("Philosopher %d releases sticks %d and %d\n", i, left, right); }

    phil_states[i] = THINKING;
}

//Deadlock free version of dining philosophers

proctype Philosopher(byte i) {

    phil_states[i] = THINKING;

    do
    :: printf("Philosopher %d is thinking...\n", i);
       
       phil_states[i] = HUNGRY;
    
       pick_both_sticks(i);
       progress: printf("Philosopher %d is eating...\n", i);
       phil_states[i] = EATING;

       release_both_sticks(i);
    od
}

proctype Stick(byte j) {

    byte left;
    if
        :: j > 0 -> left = j-1;
        :: j == 0 -> left = 4;
    fi
    byte right = j;
    byte phil;
    
    // odd sticks are first available to philosophers on the right
    if 
        :: j % 2 -> stick_states[j] = AVAIL_TO_RIGHT;
        :: else -> stick_states[j] = AVAIL_TO_LEFT;
    fi

    do
    :: stick_states[j] == AVAIL_TO_RIGHT -> toStick[j] ? REQ, phil;
                                            if 
                                            :: phil == right ->  stick_states[j] = OCCUPIED;
                                                                 toPhil[phil] ! ACC;
                                            :: else -> toPhil[phil] ! DEN;
                                            fi
                                           
    :: stick_states[j] == AVAIL_TO_LEFT -> toStick[j] ? REQ, phil;
                                            if 
                                            :: phil == left ->  stick_states[j] = OCCUPIED;
                                                                 toPhil[phil] ! ACC;
                                            :: else -> toPhil[phil] ! DEN;
                                            fi

    :: stick_states[j] == OCCUPIED -> toStick[j] ? REL, phil;
                                       if 
                                        :: phil == left ->  stick_states[j] = AVAIL_TO_RIGHT;
                                        :: phil == right -> stick_states[j] = AVAIL_TO_LEFT;
                                       fi
    od 
}


init {
    atomic {
        byte i;

        // Start all stick processes
        i = 0;
        do
        :: i < 5 -> run Stick(i); i++
        :: else -> break
        od;

        // Start all philosopher processes
        i = 0;
        do
        :: i < 5 -> run Philosopher(i); i++
        :: else -> break
        od;
    }

}


// System requirements

// No deadlock
ltl no_deadlock { [] ! ( (phil_states[0] == HUNGRY && phil_states[1] == HUNGRY 
                    && phil_states[2] == HUNGRY  && phil_states[3] == HUNGRY 
                    && phil_states[4] == HUNGRY) && (stick_states[0] == OCCUPIED 
                    && stick_states[1] == OCCUPIED && stick_states[2] == OCCUPIED 
                    && stick_states[3] == OCCUPIED && stick_states[4] == OCCUPIED)) }

// Starvation freedom
ltl alive_0 { [] <> (phil_states[0] == EATING) }
ltl alive_1 { [] <> (phil_states[1] == EATING) }
ltl alive_2 { [] <> (phil_states[2] == EATING) }
ltl alive_3 { [] <> (phil_states[3] == EATING) }
ltl alive_4 { [] <> (phil_states[4] == EATING) }