---- MODULE MC ----
EXTENDS LinearSnapshot, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
w1, w2, w3
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
v1, v2
----

\* MV CONSTANT definitions Writers
const_1541673235410168000 == 
{w1, w2, w3}
----

\* MV CONSTANT definitions Readers
const_1541673235411169000 == 
{r1, r2}
----

\* MV CONSTANT definitions RegVals
const_1541673235411170000 == 
{v1, v2}
----

\* CONSTANT definitions @modelParameterConstants:2InitRegVal
const_1541673235411171000 == 
v1
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1541673235411174000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1541673235411175000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Thu Nov 08 18:33:55 CST 2018 by hengxin
