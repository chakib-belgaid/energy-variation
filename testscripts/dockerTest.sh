
# testcore290319 paranoia-4.rennes.grid5000.fr
# testcore290319 paranoia-8.rennes.grid5000.fr

ncores=20 
duration=500
sleepduration=150

for i in {1..50} ; do 
    echo testing $i 
    sleep $sleepduration
    docker run --rm -it  polinux/stress stress -c $ncores -t $duration | ./listener.sh testdocker_1_"$i" 
    sleep $sleepduration
    stress -c $ncores -t $duration | ./listener.sh testbinarry_1_"$i" ;
done



