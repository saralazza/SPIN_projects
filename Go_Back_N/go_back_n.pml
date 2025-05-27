#define N 5 /* window size */
#define Wrong(x) x = (x+1) % N /* wrong: assume seq numbers range from 0 to N-1 */
#define Right(x) x = (x+1) % (N + 1) /* correct: assume seq numbers range from 0 to N */
#define inc(x) Right(x)

chan q[2] = [N] of { byte, byte }; /* input and ouput channels, containing packet and ACK numbers */

active [2] proctype peer() /* start two copies of the process */
{ 
    byte next_frame, exp_ack, exp_frame;
    byte r, s, nbuf, i;
    chan in, out;
    in = q[_pid]; /* one process has PID=0, the other PID=1 */
    out = q[1-_pid];
    xr in; xs out; /* exclusive send/receive: optimize partial order reduction */

    do
    :: nbuf < N -> /* outgoing messages */
        nbuf++;
        out ! next_frame, (exp_frame + N) % (N + 1); 
        inc(next_frame)

    :: in ? r,s -> /* incoming messages: frame r, ack s*/

        if /* receiver side */
        :: r == exp_frame ->
            printf("MSC: accept %d\n", r);
            inc(exp_frame)
        :: else /* discard message */
        fi;

        do /* sender side */
        :: ((exp_ack <= s) && (s < next_frame)) || 
        ((exp_ack <= s) && (next_frame < exp_ack)) || 
        ((s < next_frame) && (next_frame < exp_ack)) ->
            nbuf--;
            inc(exp_ack)
        :: else -> break
        od

    :: timeout -> /* retransmission timeout */
        next_frame = exp_ack;
        printf("MSC: timeout\n");
        i = 1;
        do
        :: i <= nbuf ->
            out ! next_frame, (exp_frame + N) % (N + 1);
            inc(next_frame);
            i++
        :: else -> break
        od
    od
}
