#! /bin/bash
name=$1
time=$2
database="variation"
cluster="dahu"
site="grenoble"
machinenumber=$3
mongoserver="mongodb://172.16.45.8:27017"
echo "$cluster-$machinenumber.$site.grid5000.fr"

while getopts "s" o; do
    case "${o}" in
        s) 
            snmp="1"
            ;;

    esac
done
shift $((OPTIND-1))


docker-machine create -d g5k \
--engine-storage-driver "overlay2" \
--engine-opt "data-root=/tmp/docker" \
--g5k-image "debian9-x64-min" \
--g5k-site "$site" \
--g5k-walltime "$time" \
--g5k-resource-properties "network_address in ('$cluster-$machinenumber.$site.grid5000.fr')" \
--engine-insecure-registry  "172.16.45.6:5000" \
$name  && \
docker-machine ssh $name apt-get install screen 
docker-machine ssh $name modprobe msr && \
docker-machine ssh $name docker run --privileged --restart=always --name zmartwatts-sensor -td -v /sys:/sys -v /tmp/docker/containers:/var/lib/docker/containers:ro gfieni/powerapi:sensor -n $name -r "mongodb" -U "mongodb://172.16.45.8:27017" -D "$database" -C rapl"$name" \
        -s "rapl" -o -e "RAPL_ENERGY_PKG" -e "RAPL_ENERGY_DRAM" \
        -s "pcu" -o -e "UNC_P_POWER_STATE_OCCUPANCY:CORES_C0" -e "UNC_P_POWER_STATE_OCCUPANCY:CORES_C3" -e "UNC_P_POWER_STATE_OCCUPANCY:CORES_C6" \
        -c "core" -e "CPU_CLK_THREAD_UNHALTED:REF_P" -e "CPU_CLK_THREAD_UNHALTED:THREAD_P" -e "LLC_MISSES"



if [[! -z $ipmi ]] ; then 
docker run --name ipmisenspr -s ipmi -i SENSOR_ID -f FREQUENCY --output_uri MONGODB_URI --output_db DB --output_collection COLLECTION
fi 

if [[ ! -z $snmp ]] ; then 

echo starting snmp 
`ssh mbelgaid@frontend.lille.grid5000.fr python3 /home/mbelgaid/github/G5K-energy/script/snmp-sensor.py  $mongoserver $database snmp$name $site  $cluster  $cluster-$machinenumber ` &
fi 




#(./allTest.sh $name)
