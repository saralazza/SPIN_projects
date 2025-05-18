#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM liveness_queue */
	case 3: // STATE 1 - _spin_nvr.tmp:34 - [(!((head!=tail)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[6][1] = 1;
		if (!( !((((int)now.head)!=((int)now.tail)))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 8 - _spin_nvr.tmp:39 - [(!((head!=tail)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[6][8] = 1;
		if (!( !((((int)now.head)!=((int)now.tail)))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 13 - _spin_nvr.tmp:41 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[6][13] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM liveness_writers */
	case 6: // STATE 1 - _spin_nvr.tmp:23 - [(!(writing))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[5][1] = 1;
		if (!( !(((int)now.writing))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 8 - _spin_nvr.tmp:28 - [(!(writing))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[5][8] = 1;
		if (!( !(((int)now.writing))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 13 - _spin_nvr.tmp:30 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[5][13] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM liveness_readers */
	case 9: // STATE 1 - _spin_nvr.tmp:12 - [(!((counter>0)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][1] = 1;
		if (!( !((now.counter>0))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 8 - _spin_nvr.tmp:17 - [(!((counter>0)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][8] = 1;
		if (!( !((now.counter>0))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 13 - _spin_nvr.tmp:19 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][13] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM mutual_exclusion */
	case 12: // STATE 1 - _spin_nvr.tmp:3 - [(!(!(((counter>0)&&writing))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][1] = 1;
		if (!( !( !(((now.counter>0)&&((int)now.writing))))))
			continue;
		/* merge: assert(!(!(!(((counter>0)&&writing)))))(0, 2, 6) */
		reached[3][2] = 1;
		spin_assert( !( !( !(((now.counter>0)&&((int)now.writing))))), " !( !( !(((counter>0)&&writing))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[3][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 13: // STATE 10 - _spin_nvr.tmp:8 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 14: // STATE 1 - readers_writers.pml:85 - [printf('System init: Spawning %d Readers and %d Writers. QSIZE=%d\\n',3,2,(3+2))] (0:8:1 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		Printf("System init: Spawning %d Readers and %d Writers. QSIZE=%d\n", 3, 2, (3+2));
		/* merge: i = 0(8, 2, 8) */
		reached[2][2] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 9, 8) */
		reached[2][9] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 15: // STATE 3 - readers_writers.pml:90 - [((i<3))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][3] = 1;
		if (!((((int)((P2 *)_this)->i)<3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 4 - readers_writers.pml:90 - [(run Reader(i))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (!(addproc(II, 1, 0, ((int)((P2 *)_this)->i))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 5 - readers_writers.pml:90 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[2][5] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = (((int)((P2 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 11 - readers_writers.pml:95 - [i = 0] (0:17:1 - 3)
		IfNotBlocked
		reached[2][11] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 18, 17) */
		reached[2][18] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 19: // STATE 12 - readers_writers.pml:97 - [((i<2))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][12] = 1;
		if (!((((int)((P2 *)_this)->i)<2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 13 - readers_writers.pml:97 - [(run Writer(i))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][13] = 1;
		if (!(addproc(II, 1, 1, ((int)((P2 *)_this)->i))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 21: // STATE 14 - readers_writers.pml:97 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[2][14] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = (((int)((P2 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 20 - readers_writers.pml:101 - [printf('System init: All processes spawned.\\n')] (0:21:0 - 3)
		IfNotBlocked
		reached[2][20] = 1;
		Printf("System init: All processes spawned.\n");
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 21 - readers_writers.pml:102 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][21] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Writer */
	case 24: // STATE 1 - readers_writers.pml:55 - [mypos = tail] (0:10:4 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->mypos);
		((P1 *)_this)->mypos = ((int)now.tail);
#ifdef VAR_RANGES
		logval("Writer:mypos", ((int)((P1 *)_this)->mypos));
#endif
		;
		/* merge: q_id[mypos] = id(10, 2, 10) */
		reached[1][2] = 1;
		(trpt+1)->bup.ovals[1] = ((int)q_id[ Index(((int)((P1 *)_this)->mypos), 5) ]);
		q_id[ Index(((P1 *)_this)->mypos, 5) ] = ((int)((P1 *)_this)->id);
#ifdef VAR_RANGES
		logval("q_id[Writer:mypos]", ((int)q_id[ Index(((int)((P1 *)_this)->mypos), 5) ]));
#endif
		;
		/* merge: q_kind[mypos] = 1(10, 3, 10) */
		reached[1][3] = 1;
		(trpt+1)->bup.ovals[2] = ((int)q_kind[ Index(((int)((P1 *)_this)->mypos), 5) ]);
		q_kind[ Index(((P1 *)_this)->mypos, 5) ] = 1;
#ifdef VAR_RANGES
		logval("q_kind[Writer:mypos]", ((int)q_kind[ Index(((int)((P1 *)_this)->mypos), 5) ]));
#endif
		;
		/* merge: tail = ((tail+1)%(3+2))(10, 4, 10) */
		reached[1][4] = 1;
		(trpt+1)->bup.ovals[3] = ((int)now.tail);
		now.tail = ((((int)now.tail)+1)%(3+2));
#ifdef VAR_RANGES
		logval("tail", ((int)now.tail));
#endif
		;
		_m = 3; goto P999; /* 3 */
	case 25: // STATE 6 - readers_writers.pml:64 - [((((mypos==head)&&(counter==0))&&(writing==0)))] (13:0:2 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		if (!((((((int)((P1 *)_this)->mypos)==((int)now.head))&&(now.counter==0))&&(((int)now.writing)==0))))
			continue;
		/* merge: writing = 1(13, 7, 13) */
		reached[1][7] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.writing);
		now.writing = 1;
#ifdef VAR_RANGES
		logval("writing", ((int)now.writing));
#endif
		;
		/* merge: printf('Writer %d (pos %d, q_id[head]=%d) enters.\\n',id,mypos,q_id[head])(13, 8, 13) */
		reached[1][8] = 1;
		Printf("Writer %d (pos %d, q_id[head]=%d) enters.\n", ((int)((P1 *)_this)->id), ((int)((P1 *)_this)->mypos), ((int)q_id[ Index(((int)now.head), 5) ]));
		/* merge: head = ((head+1)%(3+2))(13, 9, 13) */
		reached[1][9] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.head);
		now.head = ((((int)now.head)+1)%(3+2));
#ifdef VAR_RANGES
		logval("head", ((int)now.head));
#endif
		;
		_m = 3; goto P999; /* 3 */
	case 26: // STATE 11 - readers_writers.pml:76 - [writing = 0] (0:14:1 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		(trpt+1)->bup.oval = ((int)now.writing);
		now.writing = 0;
#ifdef VAR_RANGES
		logval("writing", ((int)now.writing));
#endif
		;
		/* merge: printf('Writer %d leaves.\\n',id)(14, 12, 14) */
		reached[1][12] = 1;
		Printf("Writer %d leaves.\n", ((int)((P1 *)_this)->id));
		/* merge: .(goto)(0, 15, 14) */
		reached[1][15] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 27: // STATE 17 - readers_writers.pml:80 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][17] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Reader */
	case 28: // STATE 1 - readers_writers.pml:23 - [mypos = tail] (0:10:4 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)((P0 *)_this)->mypos);
		((P0 *)_this)->mypos = ((int)now.tail);
#ifdef VAR_RANGES
		logval("Reader:mypos", ((int)((P0 *)_this)->mypos));
#endif
		;
		/* merge: q_id[mypos] = id(10, 2, 10) */
		reached[0][2] = 1;
		(trpt+1)->bup.ovals[1] = ((int)q_id[ Index(((int)((P0 *)_this)->mypos), 5) ]);
		q_id[ Index(((P0 *)_this)->mypos, 5) ] = ((int)((P0 *)_this)->id);
#ifdef VAR_RANGES
		logval("q_id[Reader:mypos]", ((int)q_id[ Index(((int)((P0 *)_this)->mypos), 5) ]));
#endif
		;
		/* merge: q_kind[mypos] = 0(10, 3, 10) */
		reached[0][3] = 1;
		(trpt+1)->bup.ovals[2] = ((int)q_kind[ Index(((int)((P0 *)_this)->mypos), 5) ]);
		q_kind[ Index(((P0 *)_this)->mypos, 5) ] = 0;
#ifdef VAR_RANGES
		logval("q_kind[Reader:mypos]", ((int)q_kind[ Index(((int)((P0 *)_this)->mypos), 5) ]));
#endif
		;
		/* merge: tail = ((tail+1)%(3+2))(10, 4, 10) */
		reached[0][4] = 1;
		(trpt+1)->bup.ovals[3] = ((int)now.tail);
		now.tail = ((((int)now.tail)+1)%(3+2));
#ifdef VAR_RANGES
		logval("tail", ((int)now.tail));
#endif
		;
		_m = 3; goto P999; /* 3 */
	case 29: // STATE 6 - readers_writers.pml:33 - [(((mypos==head)&&(writing==0)))] (13:0:2 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		if (!(((((int)((P0 *)_this)->mypos)==((int)now.head))&&(((int)now.writing)==0))))
			continue;
		/* merge: counter = (counter+1)(13, 7, 13) */
		reached[0][7] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.counter;
		now.counter = (now.counter+1);
#ifdef VAR_RANGES
		logval("counter", now.counter);
#endif
		;
		/* merge: printf('Reader %d (pos %d, q_id[head]=%d) enters. Readers active: %d.\\n',id,mypos,q_id[head],counter)(13, 8, 13) */
		reached[0][8] = 1;
		Printf("Reader %d (pos %d, q_id[head]=%d) enters. Readers active: %d.\n", ((int)((P0 *)_this)->id), ((int)((P0 *)_this)->mypos), ((int)q_id[ Index(((int)now.head), 5) ]), now.counter);
		/* merge: head = ((head+1)%(3+2))(13, 9, 13) */
		reached[0][9] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.head);
		now.head = ((((int)now.head)+1)%(3+2));
#ifdef VAR_RANGES
		logval("head", ((int)now.head));
#endif
		;
		_m = 3; goto P999; /* 3 */
	case 30: // STATE 11 - readers_writers.pml:44 - [counter = (counter-1)] (0:14:1 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		(trpt+1)->bup.oval = now.counter;
		now.counter = (now.counter-1);
#ifdef VAR_RANGES
		logval("counter", now.counter);
#endif
		;
		/* merge: printf('Reader %d leaves. Readers active: %d.\\n',id,counter)(14, 12, 14) */
		reached[0][12] = 1;
		Printf("Reader %d leaves. Readers active: %d.\n", ((int)((P0 *)_this)->id), now.counter);
		/* merge: .(goto)(0, 15, 14) */
		reached[0][15] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 31: // STATE 17 - readers_writers.pml:48 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][17] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

