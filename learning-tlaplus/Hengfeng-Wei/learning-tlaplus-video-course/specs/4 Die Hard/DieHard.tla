------------------------------ MODULE DieHard ------------------------------
EXTENDS Integers

VARIABLES small, big   
          
TypeOK == /\ small \in 0..3 
          /\ big   \in 0..5

Init == /\ big   = 0 
        /\ small = 0

FillSmall == 
    /\ small # 3
    /\ small' = 3 
    /\ big' = big

FillBig == 
    /\ big # 5
    /\ big' = 5 
    /\ small' = small

EmptySmall == 
    /\ small # 0
    /\ small' = 0 
    /\ big' = big

EmptyBig == 
    /\ big # 0
    /\ big' = 0 
    /\ small' = small

SmallToBig == 
    /\ small # 0
    /\ big # 5
    /\ IF big + small =< 5
       THEN /\ big'   = big + small
            /\ small' = 0
       ELSE /\ big'   = 5
            /\ small' = small - (5 - big)

BigToSmall == 
    /\ big # 0
    /\ small # 3
    /\ IF big + small =< 3
       THEN /\ big'   = 0 
            /\ small' = big + small
       ELSE /\ big'   = small - (3 - big)
            /\ small' = 3

Next == 
    \/ FillSmall 
    \/ FillBig    
    \/ EmptySmall 
    \/ EmptyBig    
    \/ SmallToBig    
    \/ BigToSmall   

=============================================================================
\* Modification History
\* Last modified Mon Aug 06 21:41:02 CST 2018 by hengxin
\* Last modified Sun May 21 19:24:58 CST 2017 by ics-ant
\* Created Sun May 21 19:16:50 CST 2017 by ics-ant
