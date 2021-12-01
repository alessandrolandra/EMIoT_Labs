#!/bin/bash

DPM="../dpm-simulator/dpm_simulator"
LOAD="../workloads/workload_2.txt"
PSM="../dpm-simulator/example/psm.txt"

#ANALYSIS OF THE DELAYS WITH TIMEOUT POLICY
#WITH THIS PSM, Ptr<<Pon--> Tbe=Ttr
#IF Ttimeout<Tbe --> SOME TASKS WILL NOT BE ABLE TO RESUME TO THE ACTIVE STATE IN TIME.
#THIS SCRIPT ALLOWS TO GET FROM THE PROGRAM'S OUTPUT THE TOTAL AMOUNT OF DELAY

Tbe=5

for timeout in $(seq 0 1 $(($Tbe - 1)))
do
	$DPM -t $timeout -wl $LOAD -psm $PSM > tmp_report	
	delay=$(cat tmp_report | grep Delay | cut -d ' ' -f 5)
	if [ $timeout == 0 ] ;then
		echo "$delay,$timeout" > reportDelay.txt
	else
		echo "$delay,$timeout" >> reportDelay.txt
	fi
done

rm -f tmp_report

