mtype = { 
            // philosophers states
            THINKING, HUNGRY, EATING, 

            // chopstick states
            AVAILABLE, OCCUPIED,

            // message types for philosopher-chopstick communication
            REQ, REL, ACC
        }      

mtype phil_states[5];
mtype stick_states[5];
chan toStick[5] = [0] of {mtype, byte}
chan toPhil[5] = [0] of {mtype}

inline pick_stick(j, i) {

    toStick[j] ! REQ, i;
    toPhil[i] ? ACC;
    printf("Philosopher %d takes stick %d\n", i, j);
}

inline release_stick(j, i) {
     atomic {
        toStick[j] ! REL, i;
        printf("Philosopher %d releases stick %d\n", i, j); }

    phil_states[i] = THINKING;
}

//Deadlock prone version of dining philosophers

proctype Philosopher(byte i) {

    byte left  = i;
    byte right = (i + 1) % 5;

    phil_states[i] = THINKING;

    do
    :: printf("Philosopher %d is thinking...\n", i);
       
       phil_states[i] = HUNGRY;
       pick_stick(left, i);
       pick_stick(right, i);
       
       progress: printf("Philosopher %d is eating...\n", i);
       phil_states[i] = EATING;

       release_stick(left, i);
       release_stick(right, i);
    od
}

proctype Stick(byte j) {

    stick_states[j] = AVAILABLE;
    byte phil;

    do
    :: stick_states[j] == AVAILABLE -> toStick[j] ? REQ, phil;
                                       stick_states[j] = OCCUPIED;
                                       toPhil[phil] ! ACC;

    :: stick_states[j] == OCCUPIED -> toStick[j] ? REL, _;
                                      stick_states[j] = AVAILABLE;

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
    