#!/bin/bash

# The following parameters are for machines of the "Dahu" cluster in the "Grenoble" site of Grid'5000

docker run powerapi/rapl-formula:0.4.0 --input mongodb --uri "mongodb://172.16.45.8:27017" --db "variation" --collection "raplgenxParanoia1" --output mongodb --uri "mongodb://172.16.45.8:27017" --db "variation" --collection "powergenxParanoia1"