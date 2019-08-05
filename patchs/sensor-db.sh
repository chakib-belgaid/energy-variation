#!/bin/bash

docker run --privileged --name powerapi-sensor -td  \
    -v /sys:/sys -v /tmp/docker/containers:/var/lib/docker/containers:ro \
    powerapi/hwpc-sensor:0.1.1 \
    -n "$(hostname -f)" \
    -r "mongodb" -U "mongodb://172.16.45.8:27017" -D "variation3" -C "rapldockervsbinarry55" \
    -s "rapl" -o -e "RAPL_ENERGY_PKG" -e "RAPL_ENERGY_DRAM" \
    -s "pcu" -o -e "UNC_P_POWER_STATE_OCCUPANCY:CORES_C0" -e "UNC_P_POWER_STATE_OCCUPANCY:CORES_C3" -e "UNC_P_POWER_STATE_OCCUPANCY:CORES_C6" \
    -s "msr" -e "TSC" -e "APERF" -e "MPERF" \
    -c "core" -e "CPU_CLK_THREAD_UNHALTED:REF_P" -e "CPU_CLK_THREAD_UNHALTED:THREAD_P" -e "LLC_MISSES" -e "INSTRUCTIONS_RETIRED"

