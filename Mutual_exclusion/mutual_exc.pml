#define A_TURN 0
#define B_TURN 1

bit x = 0;      
bit y = 0;      
byte turn = A_TURN;

#define IDLE 0
#define WAITING 1
#define CRITICAL 2

byte a_state = IDLE;
byte b_state = IDLE;

active proctype A() {
    do
    ::
        a_state = IDLE;

        // assume some non-critical work

        a_state = WAITING;
        x = 1;
        turn = B_TURN;

        (y == 0 || turn == A_TURN); // busy wait on MUTEX

        // Critical section!
        a_state = CRITICAL;

        skip; // do some work

        atomic {
            x = 0;
            a_state = IDLE;
        }

    od
}

active proctype B() {
    do
    ::  // symmetric w.r.t proc A
        b_state = IDLE;

        b_state = WAITING;

        y = 1;
        turn = A_TURN;

        (x == 0 || turn == B_TURN);

        // Critical section!
        b_state = CRITICAL;

        skip; //  do some work

        atomic {
            y = 0;
            b_state = IDLE;
        }
    od
}

// LTL properties for verification

// 1. MUTEX properties expressed on process states
ltl mutex { []!(a_state == CRITICAL && b_state == CRITICAL)}

// 2. Liveness/Progress properties
ltl progress_A { [] (a_state == WAITING -> (<> (a_state == CRITICAL))) }
ltl progress_B { [] (b_state == WAITING -> (<> (b_state == CRITICAL))) }
