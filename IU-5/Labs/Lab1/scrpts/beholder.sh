#!/bin/bash
#Bash script: check info
#Author: Latypov AF
#Date: 23.04.2024
echo
echo "Hello! I am $0. I'am here $PWD"
echo
date +"%d.%m.%Y %H:%M:%S"
echo
echo "============================================================================================================"
cat /proc/loadavg | awk '{print"LA: "$1,$2,$3" processes:" $4, "last PID:" $5}'
echo "============================================================================================================"
echo
echo "Net-------------------"
echo "============================================================================================================"
ss -4tulpn | column -t | awk '{ print $1" ",$2"  ",$5"  ",$6 }'
echo "============================================================================================================"
echo
echo "Потребление SWAP"
echo "============================================================================================================"
for file in /proc/*/status ; do awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file; done | sort -k 2 -n -r | head
echo "============================================================================================================"
echo
echo "IP-addresses:"
echo "============================================================================================================"
ip a | awk '/inet/' | grep eth | awk -F" " '{ print $2 }'
curl icanhazip.com
echo "============================================================================================================"
echo
echo "Disk free:type fs, free"
echo "============================================================================================================"
df -hT
echo "============================================================================================================"
echo
echo "Inode free"
echo "============================================================================================================"
df -hi
echo "============================================================================================================"
echo
echo "Next search by name"
echo "============================================================================================================"
for i in "$@"
do
  echo "Next search by name: $i"
  ps aux | grep -E "[ ]$i" | grep -v grep
  echo
done
echo "============================================================================================================"


#Task: Find out who is monopolizing or eating the CPUs

# Finally, you need to determine which process is 
# monopolizing or eating the CPUs. 
# Following command will displays the top 10 CPU users 
# on the Linux system using the combination of ps command, 
# sort command and head command/less commands. Try it out:
# ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10

# OR
# ps -eo pcpu,pid,user,args | sort -r -k1 | less 

