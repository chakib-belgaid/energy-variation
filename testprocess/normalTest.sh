#! /bin/bash 

ncores=20
duration=300


for i in {1..20} ; do 
    echo testing $i 
    docker run --rm -it --name normalTest'_'$ncores'_'$duration'_'$i polinux/stress stress -c $ncores -t $duration   
done

