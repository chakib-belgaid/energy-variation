#!/bin/bash 

ncores=64
duration=300
machineName=$1
rebootTime=200


## normal test 
for i in {1..15} ; do 
    echo normalTest'_'$ncores'_'$duration'_'$i
    docker-machine ssh $machineName docker run --rm -i --name normalTest'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration   

done

docker-machine ssh $machineName reboot
sleep $rebootTime 
(./start.sh $machineName)

## CacheClean test 
docker-machine scp cacheclean.sh $machineName:/root/cc.sh
docker-machine ssh $machineName chmod +x cc.sh
for i in {1..15} ; do 
    echo cachecleanTest'_'$ncores'_'$duration'_'$i
    docker-machine ssh $machineName docker run --rm -i --name cachecleanTest'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration  
    docker-machine ssh $machineName bash /root/cc.sh

done

docker-machine ssh $machineName reboot
sleep $rebootTime 
(./start.sh $machineName)


#reboot test 
for i in {1..15} ; do 
    echo testing rebootTest'_'$ncores'_'$duration'_'$i 
    docker-machine ssh $machineName docker run --rm -i --name rebootTest'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration 
    docker-machine ssh $machineName reboot
    sleep $rebootTime 
    (./start.sh $machineName)         
done


#sleep  test 
sleepduration=60
for i in {1..15} ; do 
    echo testing sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i
    sleep $sleepduration
    docker-machine ssh $machineName docker run --rm -i --name sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration   
done

sleepduration=180
for i in {1..15} ; do 
    echo testing sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i
    sleep $sleepduration
    docker-machine ssh $machineName docker run --rm -i --name sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration   
done

sleepduration=300
for i in {1..15} ; do 
    echo testing sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i
    sleep $sleepduration
    docker-machine ssh $machineName docker run --rm -i --name sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration   
done