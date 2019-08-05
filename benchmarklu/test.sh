#! /bin/bash

docker pull chakibmed/lu:1.0
apt-get update && apt-get -y install gfortran

echo "state;target;timestamp" >dockervsbinarry55.log.csv
for i in {1..100} ; do 
    echo "begin;docker_lu_$i;`date +"%s"`" >> dockervsbinarry55.log.csv
    docker run --rm -it --name docker_lu_$i chakibmed/lu:1.0 
    echo "end;docker_lu_$i;`date +"%s"`" >> dockervsbinarry55.log.csv 
    sleep 5 
    echo "begin;bin_lu_$i;`date +"%s"`" >> dockervsbinarry55.log.csv
    ./lu.C.x 
    echo "end;bin_lu_$i;`date +"%s"`" >> dockervsbinarry55.log.csv
done 

