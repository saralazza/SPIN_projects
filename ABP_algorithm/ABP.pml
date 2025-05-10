mtype {MSG, ACK};

// The communication is asynchronous, the channels are buffered.
// Define the channel to send something to the Receiver.
// This channel will be used from the Sender to write and from the Receiver to read data.
chan toR = [1] of {mtype, byte, bit};
// Define the channel to send something to the Sender.
// This channel will be used from the Sender to read and from the Receiver to write data.
chan toS = [1] of {mtype, bit};

active proctype Sender()
{
    byte data;
    bit sendb, recvb;
    sendb = 0;
    data = 0;
    do
    :: toR ! MSG(data, sendb) -> // The sender writes a message...
        printf("Sender: Sending MSG(%d, %d)\n", data, sendb);
        toS ? ACK(recvb); // ... and read the ack bit sent by the receiver
        printf("Sender: Received ACK(%d)\n", recvb);

        // Compare the receive bit with the expected one.
        if
        :: recvb == sendb -> // If they are equal, pass to the next data and change the expected bit.
            sendb = 1 - sendb;
            data = data + 1;
        :: else // Otherwise resend the same data.
        fi
    od
}

active proctype Receiver()
{
    byte senddata, recvdata;
    bit sendb, recvb;
    recvb = 0;
    recvdata = 0;
    do
    :: toR ? MSG(senddata, sendb) -> // The receiver reads data...
        printf("Receiver: Received MSG(%d, %d)\n", senddata, sendb);
        
        // Compare the sender bit with the expected one.
        if
        :: (sendb == recvb) -> // If thery are equal, check if the received date are the right one.
            assert(senddata == recvdata);
            recvb = 1 - recvb; // If it receives the right data, change the expected bit...
            recvdata = recvdata + 1; //... and pass to the next data
        :: else
        fi;
        toS ! ACK(sendb); // ... and writes the bit sent by the sender
        printf("Receiver: Sending ACK(%d)\n", sendb); 
    od
}
