from debian:9.9 
RUN apt-get update && apt-get -y install gfortran
ADD lu.C.x lu 
ENTRYPOINT [ "./lu" ]