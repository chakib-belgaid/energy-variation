#!/bin/bash 

ncores=32
duration=300
machineName=$1
rebootTime=200
coresCount=63

 ## normal_normal
 for i in {1..30} ; do 
     echo 'normal_normal_EP_D_32_50p_'$i
     docker-machine ssh $machineName docker run --rm -i --cpuset-cpus="1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63" --name 'normal_normal_EP_D_32_50p_'$i 172.16.45.6:5000/npb -np 32 ep.D.32 

 done

docker-machine ssh $machineName reboot
sleep $rebootTime 
(./start.sh $machineName)

## normal_CacheClean  
docker-machine scp cacheclean.sh $machineName:/root/cc.sh
docker-machine ssh $machineName chmod +x cc.sh
for i in {1..30} ; do 
    echo 'normal_cacheclean_EP_D_32_50p_'$i
    docker-machine ssh $machineName bash /root/cc.sh
    docker-machine ssh $machineName docker run --rm -i --cpuset-cpus="1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63" --name 'normal_cacheclean_EP_D_32_50p_'$i 172.16.45.6:5000/npb -np 32 ep.D.32 

done
##############################################cstates################################
(./c_states_off.sh $machineName)
(./start.sh $machineName)

 ## cstates_normal
 for i in {1..30} ; do 
     echo 'cstates_normal_EP_D_32_50p_'$i
     docker-machine ssh $machineName docker run --rm -i --cpuset-cpus="1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63" --name 'cstates_normal_EP_D_32_50p_'$i 172.16.45.6:5000/npb -np 32 ep.D.32 

 done

docker-machine ssh $machineName reboot
sleep $rebootTime 
(./start.sh $machineName)

## cstates_CacheClean  
docker-machine scp cacheclean.sh $machineName:/root/cc.sh
docker-machine ssh $machineName chmod +x cc.sh
for i in {1..30} ; do 
    echo 'cstates_cacheclean_EP_D_32_50p_'$i
    docker-machine ssh $machineName bash /root/cc.sh
    docker-machine ssh $machineName docker run --rm -i --cpuset-cpus="1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63" --name 'cstates_cacheclean_EP_D_32_50p_'$i 172.16.45.6:5000/npb -np 32 ep.D.32 

done

##############################################pstates################################
(./c_states_on.sh $machineName)
(./p_states_off.sh $machineName)
(./start.sh $machineName)

 ## pstates_normal
 for i in {1..30} ; do 
     echo 'pstates_normal_EP_D_32_50p_'$i 
     docker-machine ssh $machineName docker run --rm -i --cpuset-cpus="1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63" --name 'pstates_normal_EP_D_32_50p_'$i 172.16.45.6:5000/npb -np 32 ep.D.32 

 done

docker-machine ssh $machineName reboot
sleep $rebootTime 
(./p_states_off.sh $machineName)
(./start.sh $machineName)

## pstates_CacheClean  
docker-machine scp cacheclean.sh $machineName:/root/cc.sh
docker-machine ssh $machineName chmod +x cc.sh
for i in {1..30} ; do 
    echo 'pstates_cacheclean_EP_D_32_50p_'$i
    docker-machine ssh $machineName bash /root/cc.sh
    docker-machine ssh $machineName docker run --rm -i --cpuset-cpus="1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63" --name 'pstates_cacheclean_EP_D_32_50p_'$i 172.16.45.6:5000/npb -np 32 ep.D.32 

done
##############################################cstates/pstates################################
(./c_states_off.sh $machineName)
(./p_states_off.sh $machineName)
(./start.sh $machineName)


 ## cpstates_normal
 for i in {1..30} ; do 
     echo 'cpstates_normal_EP_D_32_50p_'$i
     docker-machine ssh $machineName docker run --rm -i --cpuset-cpus="1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63" --name 'cpstates_normal_EP_D_32_50p_'$i 172.16.45.6:5000/npb -np 32 ep.D.32

 done

docker-machine ssh $machineName reboot
sleep $rebootTime 
(./p_states_off.sh $machineName)
(./start.sh $machineName)

## cpstates_CacheClean  
docker-machine scp cacheclean.sh $machineName:/root/cc.sh
docker-machine ssh $machineName chmod +x cc.sh
for i in {1..30} ; do 
    echo 'cpstates_cacheclean_EP_D_32_50p_'$i
    docker-machine ssh $machineName bash /root/cc.sh
    docker-machine ssh $machineName docker run --rm -i --cpuset-cpus="1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63" --name 'cpstates_cacheclean_EP_D_32_50p_'$i 172.16.45.6:5000/npb -np 32 ep.D.32

done
