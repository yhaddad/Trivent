#!/bin/sh
# this retries uploading a file to grid
# until success (up to some max number of tries)
filename=$1
destinationDir=$2
COUNTER=0
EXITCODE=1
MAXTRIES=10
WAIT=10m
STORAGE_SITE=polgrid4.in2p3.fr
echo carefulUpload $filename $destinationDir
while [ $COUNTER -lt $MAXTRIES ]; do
    let COUNTER=COUNTER+1
    if [ ${EXITCODE} != 0 ]; then
	echo upload attempt $COUNTER $EXITCODE
        lcg-del -a lfn:${destinationDir}/${filename}
        lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:${destinationDir}/${filename} file:./${filename}
        EXITCODE=$?
	if [ ${EXITCODE} != 0 ]; then
            echo failed $EXITCODE sleeping...
            sleep $WAIT
	    fi
    fi
done
exit $EXITCODE
