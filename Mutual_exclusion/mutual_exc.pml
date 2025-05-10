#define A_TURN 0
#define B_TURN 1

bit x = 0;      
bit y = 0;      
byte turn = A_TURN;
byte mutex = 0;  

active proctype A() {
    do
    ::  atomic {
            x = 1;                 
            turn = B_TURN;        
        }
        do
        :: (y == 0 || turn == A_TURN) -> break
        od;

        atomic {
            mutex++;              
            assert(mutex == 1);  
            printf("A entra nella sezione critica\n");

            printf("A lavora nella sezione critica\n");

            printf("A esce dalla sezione critica\n");
            mutex--;
            x = 0;           
        }
    od
}

active proctype B() {
    do
    ::  atomic {
            y = 1;
            turn = A_TURN;
        }

        do
        :: (x == 0 || turn == B_TURN) -> break
        od;

        atomic {
            mutex++;
            assert(mutex == 1);
            printf("B entra nella sezione critica\n");

    
            printf("B lavora nella sezione critica\n");

            printf("B esce dalla sezione critica\n");
            mutex--;
            y = 0;
        }
    od
}
