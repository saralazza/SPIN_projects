mtype {MSG, ACK};

// The starting envirorment is the same of the ABP example.
chan toR = [1] of {mtype, byte, bit};
chan toS = [1] of {mtype, bit};

active proctype Sender()
{
    byte data;
    bit sendb, recvb;
    sendb = 0;
    data = 0;
    do
    :: toR ! MSG(data, sendb) ->
        if
        :: toS ? ACK(recvb);
            if
            :: recvb == sendb ->
                sendb = 1 - sendb;
                data = data + 1;
            :: else
            fi
        :: toR ? _, _, _ -> // Read the message witten by Sender for the Receiver. Steal the data.
            printf("Receiver lost a message\n");
        :: timeout
        fi;
    od
}

active proctype Receiver()
{
    byte senddata, recvdata;
    bit sendb, recvb;
    recvb = 0;
    recvdata = 0;
    do
    :: toR ? MSG(senddata, sendb) ->
        if
        :: (sendb == recvb) ->
            assert(senddata == recvdata);
            recvb = 1 - recvb;
            recvdata = recvdata + 1;
        :: else
        fi;
        toS ! ACK(sendb);
    od
}