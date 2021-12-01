#!/bin/bash

#script used to start the dpm simulator on predefined sequence of timeout values
#the sequence is defined by the 'seq' command
#ex: seq 0 1 5   =   {0 1 2 3 4 5}
#	   seq 0 0.1 1 =   {0 0.1 0.2 ... 1}
#'Max' should be 2*(break event time) which depend on the psm used
#OSS: if the costs of the transitions are very close to 0 (or << Power On) the definition of
#			break event time does not work anymore..
DPM="../dpm-simulator/dpm_simulator"
LOAD="../workloads/workload_2.txt"
PSM="../dpm-simulator/example/psm.txt"
Min=0
Max=200
if [ $# -eq 1 ] ;then
	if [ -f $1 ] ;then
		LOAD=$1
		echo "Workload: $LOAD"
	else
		echo "Workload file doesn't exist, using def $LOAD"
	fi
fi

for timeout in $(seq $Min 1 $Max)
do
	$DPM -t $timeout -wl $LOAD -psm $PSM > tmp_report
	if [ $timeout == 0 ];then
		energy=$(cat tmp_report | grep DPM | tr -s ' ' | cut -d ' ' -f6 | tr -d J)
		echo $energy > report.txt
	fi
	energy=$(cat tmp_report | grep DPM | tr -s ' ' | cut -d ' ' -f11 | tr -d J)
	echo "$energy,$timeout" >> report.txt
done
rm -f tmp_report

