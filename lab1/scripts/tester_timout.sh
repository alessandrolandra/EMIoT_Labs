#!/bin/bash

DPM="../dpm-simulator/dpm_simulator"
LOAD="../workloads/workload_2.txt"
PSM="../dpm-simulator/example/psm.txt"
Max=10
if [ $# -eq 1 ] ;then
	if [ -f $1 ] ;then
		LOAD=$1
		echo "Workload: $LOAD"
	else
		echo "Workload file doesn't exist, using def $LOAD"
	fi
fi

for timeout in $(seq 0 0.01 $Max)
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




