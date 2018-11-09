------------------------------- MODULE CSComm -------------------------------
(***************************************************************************)
(* Specification of communication in a Client-Server system model.         *)
(***************************************************************************)
EXTENDS Integers, Naturals, OpOperators

CONSTANTS
    Client,    \* the set of clients
    Server,     \* the (unique) server
    Op,
    Msg

VARIABLES
    cincoming,  \* cincoming[c]: incoming channel at the client c \in Client
    sincoming   \* incoming channel at the Server
-----------------------------------------------------------------------------
vars == <<cincoming, sincoming>>
-----------------------------------------------------------------------------
TypeOK == 
    /\ cincoming \in [Client -> Seq(Msg)]
    /\ sincoming \in Seq(Msg)
-----------------------------------------------------------------------------
(*********************************************************************)
(* The initial predicate.                                            *)
(*********************************************************************)
Init == 
    /\ cincoming = [c \in Client |-> <<>>]
    /\ sincoming = <<>>
-----------------------------------------------------------------------------
(*********************************************************************)
(* A client sends a message msg to the Server.                       *)
(*********************************************************************)
CSend(msg) == 
    /\ sincoming' = Append(sincoming, msg)
    /\ UNCHANGED cincoming
(*********************************************************************)
(* A client receives a message from the Server.                  *)
(*********************************************************************)
CRev(c) ==
    /\ cincoming[c] # <<>>  \* there are messages to handle with
    /\ cincoming' = [cincoming EXCEPT ![c] = Tail(@)]   \* consume a message
    /\ UNCHANGED sincoming
-----------------------------------------------------------------------------
(*********************************************************************)
(* SRev and SSend below will be used together in one subaction.      *)
(* Therefore, there are no UNCHANGED sub-formulas                    *)
(* in their definitions.                                             *)
(*********************************************************************)
(*********************************************************************)
(* The Server receives a message from some clinet c \in Client.      *)
(*********************************************************************)
SRev == 
    /\ sincoming # <<>>    \* there are messages for the Server to handle with
    /\ sincoming' = Tail(sincoming) \* consume a message
(*********************************************************************)
(* The Server sents a message to each client other than c \in Client.                                          *)
(*********************************************************************)
SSend(c, cmsg) ==
    /\ cincoming' = [cl \in Client |->
                        IF cl = c
                        THEN cincoming[cl]
                        ELSE Append(cincoming[cl], cmsg[cl])]
(*********************************************************************)
(* The Server broadcasts the same message to all the Clients         *)
(* other than c \in Client.                                          *)
(*********************************************************************)
SSendSame(c, msg) ==
    /\ SSend(c, [cl \in Client |-> msg])
(*********************************************************************)
(* The Server broadcasts messages to the Clients                     *)
(* other than c \in Client.                                          *)
(* The "ack" parts of the messages [ack: Int, op: Op] broadcast      *)
(* are determined by the parameter "acks".                           *)
(*********************************************************************)
SSend2(c, acks, xop) == 
    /\ cincoming' = [cl \in Client |->
                        IF cl = c
                        THEN cincoming[cl]
                        ELSE Append(cincoming[cl], [ack |-> acks[cl], op |-> xop])]
-----------------------------------------------------------------------------
(*********************************************************************)
(* Properties of communication.                                      *)
(*********************************************************************)
EmptyChannel == Init
=============================================================================
\* Modification History
\* Last modified Sun Sep 02 12:53:45 CST 2018 by hengxin
\* Created Sun Jun 24 10:25:34 CST 2018 by hengxin