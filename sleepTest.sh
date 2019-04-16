#! /bin/bash 

ncores=20
duration=300
sleepduration=60


for i in {1..5} ; do 
    echo testing sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i
    sleep $sleepduration
    docker run --rm -it --name sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration   
done


exit
sleepduration=180

for i in {1..5} ; do 
    echo testing sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i
    sleep $sleepduration
    docker run --rm -it --name sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration   
done

sleepduration=300

for i in {1..5} ; do 
    echo testing sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i
    sleep $sleepduration
    docker run --rm -it --name sleepTest'_'$sleepduration'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration   
done


