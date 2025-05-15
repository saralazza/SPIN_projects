#define N 5 //number of philosophers

mtype = {REQ, REL, ACC, DEN}

chan toStick[N] = [0] of {mtype, byte}
chan toPhil[N] = [0] of {mtype}


inline pick_stick(j, i) {
    assert(i >= 0 && i < N && j >=0 && j < N);
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

inline release_stick(j, i) {
    assert(i >= 0 && i < N && j >=0 && j < N);
    atomic {
        toStick[j] ! REL, i;
        printf("Philosopher %d releases stick %d\n", i, j); }
}

// Deadlock-free version of Dining Philosophers: 
// odd philosophers pick up the right stick first, then left

proctype Philosopher(byte i) {
    byte left  = i;
    byte right = (i + 1) % N;

    do
    :: printf("Philosopher %d is thinking...\n", i);
       skip; // simulate thinking time

       if
       :: i % 2 == 0 ->  // even philosophers: pick left, then right
            pick_stick(left, i);
            pick_stick(right, i);
       :: else ->        // odd philosophers: pick right, then left
            pick_stick(right, i);
            pick_stick(left, i);
       fi;

       printf("Philosopher %d is eating...\n", i);
       skip; // simulate eating time

       release_stick(left, i);
       release_stick(right, i);
    od
}


proctype Stick(byte j) {

    //Initial state: available
    bool free = true;
    mtype msg_type;
    byte phil;

    do
    :: toStick[j] ? msg_type, phil ->
        if
        :: msg_type == REQ ->
            if
            :: free ->
                free = false;
                toPhil[phil] ! ACC;
            :: else ->
                toPhil[phil] ! DEN;
            fi
        :: msg_type == REL ->
            free = true;
        fi
    od }


init {
    atomic {
        byte i;

        // Start all stick processes
        i = 0;
        do
        :: i < N -> run Stick(i); i++
        :: else -> break
        od;

        // Start all philosopher processes
        i = 0;
        do
        :: i < N -> run Philosopher(i); i++
        :: else -> break
        od;
    }
}

    