#define N 5 //number of philosophers

mtype = {REQ, REL, ACC}

chan toStick[N] = [0] of {mtype, byte}
chan toPhil[N] = [0] of {mtype, byte}

//Deadlock prone version of dining philosophers

inline pick_stick(j, i) {
    atomic {
        toStick[j] ! REQ(i);
        toPhil[i] ? ACC(i);
        printf("Philosopher %d takes stick %d\n", i, j);
} }

inline release_stick(j, i) {
     atomic {
        toStick ! REL(j, i);
        printf("Philosopher %d releases stick %d\n", i, j); }
}

proctype Philosopher(int i) {

    int left = i;
    int right = (i+1) % N;

    
    //Initial state: thinking
    printf("Philosopher %d is thinking...", i);

    do 
    ::  //Think
        skip;

    :: //Request left chopstick first
       pick_stick(left, i) -> 
       pick_stick(right, i);
       //New state: eating
       printf("Philosopher %d is eating...", i);

       if 
        :: //Release left chopstick first
         pick_stick(left, i) -> 
         pick_stick(right, i);

        :: //Release right chopstick first
         pick_stick(right, i) -> 
         pick_stick(left, i);
        fi

    :: //Request right chopstick first
       pick_stick(left, i) -> 
       pick_stick(right, i);
       //New state: eating
       printf("Philosopher %d is eating...", i);

       if 
        :: //Release left chopstick first
         pick_stick(left, i) -> 
         pick_stick(right, i);

        :: //Release right chopstick first
         pick_stick(right, i) -> 
         pick_stick(left, i);
        fi
    od
}


proctype Stick(int j) {

    //Initial state: available
    bool free = true;
    byte phil;

    do 
        :: //Manage requests
        toStick[j] ? REQ, phil -> 
        if
          :: free -> free = false; toPhil[phil] ! ACC(j);
          :: else
        fi
        
        :: //Manage release
        toStick[j] ? REL(phil) -> free = true;

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

    