/*
  Readers Writers with weak fairness:
    - multiple readers may read concurrently
    - writers get exclusive access

  weak fairness: if a process is always enabled from a certain point onwards, it will eventually be executed
    <>[] (p is enabled) -> []<> (p is executed)

  strong fairness: if a process is enabled infinitely often (repeatedly enabled), it will eventually be executed
    []<> (p is enabled) -> []<> (p is executed)

  weak fairness is a reasonable and sufficient assumption to prove that processes won't be indefinitely blocked 
    while they are consistently able to proceed, thus preventing starvation in Readers and Writers processes. 
    It's a good trade off between a realistic scheduling model and verification tractability
*/

// number of processes
#define NREADERS  3
#define NWRITERS  2


// shared variables
int counter = 0;       // number of active readers
bool writing = false;  // it's a flag for the critical section

// Reader
proctype Reader(byte id) {
  do
  :: atomic {
      //wait until there are no writers
      (writing == false) ->
       counter++;
       printf("Reader %d enters, number of readers=%d\n", id, counter);
     }
     //  reading
     // finished reading
     atomic {
       counter--;
       printf("Reader %d leaves, number of readers=%d\n", id, counter);
     }
  od
}

// Writer
proctype Writer(byte id) {
  do
  :: atomic {
       // wait until there are no readers and writers
       (counter == 0 && writing == false) ->
       writing = true;
       printf("Writer %d enters\n", id);
     }
     // writing
     // finished writing
     atomic {
       writing = false;
       printf("Writer %d leaves\n", id);
     }
  od
}

// LTL properties

/* mutual exclusion: never both reading (so counter>0) and writing (so writing==True) */
never {
  initial_state:
    if
    :: (counter > 0 && writing) -> goto accept
    :: else -> goto initial_state
    fi;
  accept:
    skip
}

// it's always true that eventually, the number of active readers will be greater than 0
// thus if a reader wants to read, it will eventually be able to do so
ltl liveness_readers { []<> (counter > 0) }

// it's always true that eventually, writers will be able to write
// thus if a writer wants to write, it will eventually be able to do so
ltl liveness_writers { []<>(writing) }


init {

  // spawn readers 
  byte i = 0;
  do
  :: i < NREADERS ->
     run Reader(i);
     i++;
  :: else -> break
  od;

  // spawn writers
  i = 0;
  do
  :: i < NWRITERS ->
     run Writer(i);
     i++;
  :: else -> break
  od;
}
