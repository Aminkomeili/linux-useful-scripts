#!/bin/bash

# Check for disk errors
echo "Checking for disk errors..."
fsck -A -y

# Check for file system errors
echo "Checking for file system errors..."
touch /forcefsck
reboot

# Check for memory errors
echo "Checking for memory errors..."
memtester 1G 1

# Check for CPU errors
echo "Checking for CPU errors..."
stress --cpu 1 --timeout 60s

# Check for network errors
echo "Checking for network errors..."
ping -c 5 google.com

# Check for DNS errors
echo "Checking for DNS errors..."
nslookup google.com
