#!/bin/bash

# The following parameters are for machines of the "Dahu" cluster in the "Grenoble" site of Grid'5000

docker run -ti --name powerapi-backend  powerapi/smartwatts-formula -D \
    --mongodb-uri "mongodb://172.16.45.8:27017"\
    --mongodb-database "variation3" \
    --mongodb-sensor-collection "cp2" \
    --mongodb-powermeter-collection "res" \
    --cpu-error-threshold 2.0 \
    --dram-error-threshold 2.0 \
    --cpu-ratio-min 10 \
    --cpu-ratio-base 21 \
    --cpu-ratio-max 37