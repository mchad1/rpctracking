#!/bin/ksh 
#https://access.redhat.com/solutions/69248
while true; do 
    grep -A8 $1 /proc/self/mountstats |  grep "xprt:" | awk '{print $9,$11,$12,$8}' | while read i; do
       divisor=`echo $i | awk '{print $1}'`
       avg_flight=`echo $i | awk '{print $2}'`
       backlog=`echo $i | awk '{print $3}'`
       cur_flight=`echo $i | awk '{print $4}'`
       aif=0 ; bl=0; cf=0
       (( aif = avg_flight / divisor ))
       (( bl = backlog / divisor ))
       (( cf = cur_flight  - divisor ))
       echo "Avg_RPC_In_Filght: $aif, Avg_Backlog: $bl,  Current_in_flight: $cf"

    done
 
#xprt: tcp 806 1 1 0 12 525556 525556 0 65784746 13192742420 128 1150041 65259209
#1     2   3   4 5 6 7  8      9     10 11       12          13   14     15
done


#Average in-flight RPC requests: 65784746 / 525556 = 125.171o
#                                 11        9
#Average RPC backlog during sends: 13192742420 / 525556 = 25102
#                                  12             9
#Current In-flight RPC requests: 525556 - 525556 = 0 (when the statistic was taken, the connection was idle).
                                 8        9
