#!/bin/bash

uptime=$(uptime -p)

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

total_ram=$(free | awk '/Mem:/ {print $2}')

used_ram=$(free -h | awk '/Mem:/ {print $3}')
used_ramp=$(free | awk '/Mem:/ {print $3}')
used_ram_p=$(awk "BEGIN {print $used_ramp / $total_ram}")
upercent=$(echo "$used_ram_p" | awk '{printf "%.2f%%\n", $1 * 100}')

free_ram=$(free -h | awk '/Mem:/ {print $4}')
free_ramp=$(free | awk '/Mem:/ {print $4}')
free_ram_p=$(awk "BEGIN {print $free_ramp / $total_ram}")
fpercent=$(echo "$free_ram_p" | awk '{printf "%.2f%%\n", $1 * 100}')

total_space=$(df -h --total | grep '^total' | awk '{print $2}' | sed 's/G//')
used_space=$(df -h --total | grep '^total' | awk '{print $3}' | sed 's/G//')
used_space_p=$(awk "BEGIN {print $used_space / $total_space}")
uspercent=$(echo "$used_space_p" | awk '{printf "%.2f%%\n", $1 * 100}')

free_space=$(df -h --total | grep '^total' | awk '{print $4}' | sed 's/G//')
free_space_p=$(awk "BEGIN {print $free_space / $total_space}")
fspercent=$(echo "$free_space_p" | awk '{printf "%.2f%%\n", $1 * 100}')

top_cpu=$(top -b -n 1 -o +%CPU | head -n 12 | tail -n 6)
top_mem=$(top -b -n 1 -o +%MEM | head -n 12 | tail -n 6)

echo "Uptime: $uptime"
echo "CPU Usage: $cpu_usage%"
echo "Used RAM: $used_ram ($upercent)"
echo "Free RAM: $free_ram ($fpercent)"
echo "Used Space: $used_space"Gb" ($uspercent)"
echo "Free Space: $free_space"Gb" ($fspercent)"
echo "Top 5 Processes by CPU:"
echo "$top_cpu"
echo "Top 5 Processes by RAM:"
echo "$top_mem"
