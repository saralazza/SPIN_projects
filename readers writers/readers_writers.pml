#define NREADERS   3
#define NWRITERS   2
#define QSIZE      (NREADERS + NWRITERS) 

// Queue variables
byte q_id[QSIZE];   // to store the ID of the process in the queue
byte q_kind[QSIZE]; // to store the kind of process (0 for reader, 1 for writer)
byte head = 0;
byte tail = 0;

// Shared variables
int counter = 0;    // number of active readers
bool writing = false; // true if a writer is currently in CS

// Reader process type
proctype Reader(byte id) {
  byte mypos;
  do 
  // loop indefinitely, repeatedly trying to read

      // 1. enqueue at the end of the queue
  ::  atomic {
       mypos = tail;
       q_id[mypos] = id;
       q_kind[mypos] = 0;  // mark as a reader (kind 0)
       tail = (tail + 1) % QSIZE; 
       // printf("Reader %d (pos %d) enqueued. Tail is now %d.\n", id, mypos, tail);
     }

     // 2. wait for turn and conditions to enter CS
     atomic {
       // condition: reader is at the head of the queue AND no writer is active
       (mypos == head && writing == false) ->
         counter = counter + 1;
         printf("Reader %d (pos %d, q_id[head]=%d) enters. Readers active: %d.\n", id, mypos, q_id[head], counter);
         head = (head + 1) % QSIZE; // Advance head, "dequeuing" this reader
     }

     // --- CS: Reading ---
     // printf("Reader %d is reading...\n", id);

     // leave Critical Section
     atomic {
       counter = counter - 1;
       printf("Reader %d leaves. Readers active: %d.\n", id, counter);
     }
  od
}

// Writer process type
proctype Writer(byte id) {
  byte mypos;
  do
  ::  atomic {
       mypos = tail;
       q_id[mypos] = id;
       q_kind[mypos] = 1;
       tail = (tail + 1) % QSIZE; 
      // printf("Writer %d (pos %d) enqueued. Tail is now %d.\n", id, mypos, tail);
     }

     atomic {
       // condition: writer is at head, no readers active, and no other writer active
       (mypos == head && counter == 0 && writing == false) ->
         writing = true;
         printf("Writer %d (pos %d, q_id[head]=%d) enters.\n", id, mypos, q_id[head]);
         head = (head + 1) % QSIZE;
     }

     // --- CS: writing ---
     // printf("Writer %d is writing...\n", id);


     // leave Critical Section
     atomic {
       writing = false; // Clear writing flag
       printf("Writer %d leaves.\n", id);
     }
  od
}

// Initialiazation process
init {
  byte i;
  printf("System init: Spawning %d Readers and %d Writers. QSIZE=%d\n", NREADERS, NWRITERS, QSIZE);

  // Spawn reader processes
  i = 0;
  do
  :: i < NREADERS -> run Reader(i); i = i + 1
  :: else -> break
  od;

  // Spawn writer processes
  i = 0;
  do
  :: i < NWRITERS -> run Writer(i); i = i + 1
  :: else -> break
  od;

  printf("System init: All processes spawned.\n");
}


// LTL properties for verification
// Globally it's not true that there are readers reading and writers writing at the same time
ltl mutual_exclusion { []( !(counter > 0 && writing) ) }

// it's always true that eventually, the number of active readers will be greater than 0
// thus if a reader wants to read, it will eventually be able to do so
ltl liveness_readers { []<>(counter > 0) }

// it's always true that eventually, writers will be able to write
// thus if a writer wants to write, it will eventually be able to do so
ltl liveness_writers { []<>(writing) }

// it's always true that eventually, the queue is not empty
ltl liveness_queue { []<>(head != tail) }