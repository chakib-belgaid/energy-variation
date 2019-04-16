#! /bin/bash 

ncores=20
duration=300
machineName=''

for i in {1..15} ; do 
    echo testing rebootTest'_'$ncores'_'$duration'_'$i 
    docker-machine ssh $machineName docker run --rm -it --name rebootTest'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration 
    docker-machine ssh $machineName reboot
      
done

