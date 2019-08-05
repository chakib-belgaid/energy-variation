#!/bin/bash 

ncores=64
duration=300
machineName=$1
rebootTime=200
coresCount=39
 ## normal  

 for i in {1..50} ; do 
     echo 'normal_normal_LU_A_2_'$i
     docker-machine ssh $machineName docker run --rm -i --name 'normal_normal_LU_A_2_'$i 172.16.45.6:5000/npb -np 64 lu.C.64 

 done

docker-machine ssh $machineName reboot
sleep $rebootTime 
(./start.sh $machineName)

## CacheClean  
docker-machine scp cacheclean.sh $machineName:/root/cc.sh
docker-machine ssh $machineName chmod +x cc.sh
for i in {1..50} ; do 
    echo cacheclean'_'LU_A_2_$i
    docker-machine ssh $machineName bash /root/cc.sh
    docker-machine ssh $machineName docker run --rm -i --name cacheclean'_LU_A_2_'$i 172.16.45.6:5000/npb -np 64 lu.C.64 

done



(./grubupdate.sh $machineName)
(./start.sh $machineName)
## nomal grubupdate
 for i in {1..50} ; do 
     echo normal'_'LU_A_2_$i
     docker-machine ssh $machineName docker run --rm -i --name grubnormal'_'LU_A_2_$i 172.16.45.6:5000/npb -np 64 lu.C.64

 done

## CacheClean grubupdate  

for i in {1..50} ; do 
    echo cacheclean'_'LU_A_2_$i
    docker-machine ssh $machineName bash /root/cc.sh
    docker-machine ssh $machineName docker run --rm -i --name grubcacheclean'_'LU_A_2_$i 172.16.45.6:5000/npb -np 64 lu.C.64 
done

## one CPU 
#(./grubupdate.sh $machineName)

#docker-machine scp disablecpu.sh $machineName:/root
#docker-machine ssh $machineName chmod +x /root/disablecpu.sh
#docker-machine ssh $machineName /root/disablecpu.sh $coresCount
#docker-machine ssh $machineName docker kill zmartwatts-sensor
#(./start.sh $machineName)

# for i in {1..50} ; do 
#     echo onecpu'_'LU_A_2_$i
#     docker-machine ssh $machineName docker run --rm -i --name onecpu'_'LU_A_2_$i 172.16.45.6:5000/npb -np 64 lu.C.64 
# done