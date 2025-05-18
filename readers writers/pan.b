	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM liveness_queue */
;
		;
		;
		;
		
	case 5: // STATE 13
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM liveness_writers */
;
		;
		;
		;
		
	case 8: // STATE 13
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM liveness_readers */
;
		;
		;
		;
		
	case 11: // STATE 13
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM mutual_exclusion */
;
		
	case 12: // STATE 1
		goto R999;

	case 13: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 14: // STATE 2
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 16: // STATE 4
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 17: // STATE 5
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 11
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 20: // STATE 13
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 21: // STATE 14
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		
	case 22: // STATE 20
		goto R999;

	case 23: // STATE 21
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Writer */

	case 24: // STATE 4
		;
		now.tail = trpt->bup.ovals[3];
		q_kind[ Index(((P1 *)_this)->mypos, 5) ] = trpt->bup.ovals[2];
		q_id[ Index(((P1 *)_this)->mypos, 5) ] = trpt->bup.ovals[1];
		((P1 *)_this)->mypos = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 25: // STATE 9
		;
		now.head = trpt->bup.ovals[1];
		now.writing = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 26: // STATE 11
		;
		now.writing = trpt->bup.oval;
		;
		goto R999;

	case 27: // STATE 17
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Reader */

	case 28: // STATE 4
		;
		now.tail = trpt->bup.ovals[3];
		q_kind[ Index(((P0 *)_this)->mypos, 5) ] = trpt->bup.ovals[2];
		q_id[ Index(((P0 *)_this)->mypos, 5) ] = trpt->bup.ovals[1];
		((P0 *)_this)->mypos = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 29: // STATE 9
		;
		now.head = trpt->bup.ovals[1];
		now.counter = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 30: // STATE 11
		;
		now.counter = trpt->bup.oval;
		;
		goto R999;

	case 31: // STATE 17
		;
		p_restor(II);
		;
		;
		goto R999;
	}

