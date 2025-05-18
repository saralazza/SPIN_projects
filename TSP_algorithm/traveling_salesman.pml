// Problem: We have N cities and to travel from the city i to the city j, there is a cost of cij.
// Goal: Starting from c0, find the path to visit all the cities and return to c0 with the minimal cost.
// Suppose to have 4 cities [c0,c1,c2,c3] and the costs are:
//          c0 c1 c2 c3
//       c0 -  7  9  2
//       c1 4  -  3  7
//       c2 6  7  -  8
//       c3 2  3  8  -

#define MIN 90
#define prop (cost >= MIN)

local bit vv[4];     // visited cities
local int cost = 0;  // total cost

active proctype TSP()
{
    // Iniziamo da città 0 (la partenza), segnata come visitata
    vv[0] = true;

    P0: atomic {
        if
        :: !vv[1] -> cost = cost + 7; vv[1] = true; goto P1
        :: !vv[2] -> cost = cost + 9; vv[2] = true; goto P2
        :: !vv[3] -> cost = cost + 2; vv[3] = true; goto P3
        fi
    }

    P1: atomic {
        if
        :: !vv[2] -> cost = cost + 3; vv[2] = true; goto P2
        :: !vv[3] -> cost = cost + 7; vv[3] = true; goto P3
        :: else -> cost = cost + 4; goto end  // return to 0
        fi
    }

    P2: atomic {
        if
        :: !vv[1] -> cost = cost + 7; vv[1] = true; goto P1
        :: !vv[3] -> cost = cost + 8; vv[3] = true; goto P3
        :: else -> cost = cost + 6; goto end  // return to 0
        fi
    }

    P3: atomic {
        if
        :: !vv[1] -> cost = cost + 3; vv[1] = true; goto P1
        :: !vv[2] -> cost = cost + 8; vv[2] = true; goto P2
        :: else -> cost = cost + 2; goto end  // return to 0
        fi
    }

    end:
        skip;
}


ltl cost_prop {<> prop}
