mtype = {A, B, I, Na, Nb, gD, R};

chan ca = [0] of {mtype, mtype, mtype, mtype};
chan cb = [0] of {mtype, mtype, mtype};

bit IniRunningAB = 0;
bit IniCommitAB = 0;
bit ResRunningAB = 0;
bit ResCommitAB = 0;

inline IniRunning(x,y) {
    if
    :: ((x==A)&&(y==B))-> IniRunningAB=1;
    :: else skip
    fi
}

inline IniCommit(x,y) {
    if
    :: ((x==A)&&(y==B))-> IniCommitAB=1; 
    :: else skip
    fi
}

inline ResRunning(x,y) {
    if
    :: ((x==A)&&(y==B))-> ResRunningAB=1 \
    :: else skip
    fi
}

inline ResCommit(x,y) {
    if
    :: ((x==A)&&(y==B))-> ResCommitAB=1 \
    :: else skip
    fi
}

inline k(x1) {
    if
        :: (x1 == Na)-> kNa = 1
        :: (x1 == Nb)-> kNb = 1
        :: else skip
    fi;
}


inline k2(x1,x2) {
    if
        :: (x1 == Nb && x2 == B)-> k_Nb__B = 1 
        :: else skip
    fi
}


inline k3(x1,x2,x3) {
    if
        :: (x1 == Na && x2 == A && x3 == B) -> k_Na_A__B = 1
        :: (x1 == Na && x2 == Nb && x3 == A) -> k_Na_Nb__A = 1
        :: else skip
    fi
}


// Initiator
proctype PIni (mtype self; mtype party; mtype nonce)
{
    mtype g1;
    atomic {
        IniRunning(self,party);
        ca ! self, nonce, self, party;
    }
    atomic {
        ca ? eval (self), eval (nonce), g1, eval (self);
        IniCommit(self,party);
        cb ! self, g1, party;
    }
}

// Responder
proctype PRes (mtype self; mtype nonce)
{
    mtype g2, g3;
    atomic {
    ca ? eval (self), g2, g3, eval (self);
    ResRunning(g3,self);
    ca ! self, g2, nonce, g3;
    }
    atomic {
    cb ? eval (self), eval (nonce), eval (self);
    ResCommit(g3,self);
    }
}

// Intruder
proctype PI ()
{
    /* The intruder always knows
    A, B, I, PK(A), PK(B), PK(I), SK(I) and gD  */

    bit kNa = 0;
    bit kNb = 0;
    bit k_Na_Nb__A = 0;
    bit k_Na_A__B = 0;
    bit k_Nb__B = 0;

    mtype x1 = 0, x2 = 0, x3 = 0;
    do
    :: ca ! B, gD, A, B
    :: ca ! B, gD, B, B
    :: ca ! B, gD, I, B
    :: ca ! B, A, A, B
    :: ca ! B, A, B, B
    :: ca ! B, A, I, B
    :: ca ! B, B, A, B
    :: ca ! B, B, B, B
    :: ca ! B, B, I, B
    :: ca ! B, I, A, B
    :: ca ! B, I, B, B
    :: ca ! B, I, I, B
    :: ca ! (kNa-> A : R), Na, Na, A
    :: ca ! (((kNa && kNb) || k_Na_Nb__A)-> A : R), Na, Nb, A
    :: ca ! (kNa-> A : R), Na, gD, A
    :: ca ! (kNa-> A : R), Na, A, A
    :: ca ! (kNa-> A : R), Na, B, A
    :: ca ! (kNa-> A : R), Na, I, A
    :: ca ! ((kNa || k_Na_A__B)-> B : R), Na, A, B
    :: ca ! (kNa-> B : R), Na, B, B
    :: ca ! (kNa-> B : R), Na, I, B
    :: ca ! (kNb-> B : R), Nb, A, B
    :: ca ! (kNb-> B : R), Nb, B, B
    :: ca ! (kNb-> B : R), Nb, I, B
    :: cb ! ((k_Nb__B || kNb)-> B : R), Nb, B
    :: d_step {
        ca ? _, x1, x2, x3;
        if
            :: (x3 == I)-> k(x1); k(x2)
            :: else k3(x1,x2,x3)
        fi;
        x1 = 0;
        x2 = 0;
        x3 = 0;
    }
    :: d_step {
        cb ? _, x1, x2;
        if
            :: (x2 == I)-> k(x1)
            :: else k2(x1,x2)
        fi;
        x1 = 0;
        x2 = 0; }
    od 
}

init
{
 atomic {
    if
    :: run PIni (A, I, Na)
    :: run PIni (A, B, Na)
    fi;
    run PRes (B, Nb);
    run PI ();
 }
}

// Properties for correct authentication order
ltl aut_AB { [] ( ([] !IniCommitAB) || (!IniCommitAB U ResRunningAB) ) }
ltl aut_BA { [] ( ([] !ResCommitAB) || (!ResCommitAB U IniRunningAB) ) }
