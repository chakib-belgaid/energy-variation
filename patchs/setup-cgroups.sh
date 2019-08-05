#!/bin/bash

# This script should be run at every reboot of the node

PERF_CGROUP="/sys/fs/cgroup/perf_event"
SYSTEM_CGROUP="$PERF_CGROUP/system"
KERNEL_CGROUP="$PERF_CGROUP/kernel"

mkdir -p $SYSTEM_CGROUP
mkdir -p $KERNEL_CGROUP

while read pid
do
    if [ -f "/proc/$pid/cmdline" ]
    then
        if [ $(cat "/proc/$pid/cmdline" |wc -w) -gt 0 ]
        then
           echo $pid >$SYSTEM_CGROUP/cgroup.procs
        else
           echo $pid >$KERNEL_CGROUP/cgroup.procs
        fi
    fi
done <$PERF_CGROUP/cgroup.procs