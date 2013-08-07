#!/bin/sh
# this retries uploading a file to grid
# until success (up to some max number of tries)
filename=$1
originalDir=$2
COUNTER=0
EXITCODE=1
MAXTRIES=10
WAIT=1m
STORAGE_SITE=polgrid4.in2p3.fr
echo $COUNTER $EXITCODE
echo carefulDownload $filename $originalDir
while [ $COUNTER -lt $MAXTRIES ]; do
    let COUNTER=COUNTER+1
    if [ ${EXITCODE} != 0 ]; then
	echo download attempt $COUNTER $EXITCODE
	lcg-cp -v lfn:${originalDir}/${filename} file:./${filename}
        EXITCODE=$?
	if [ ${EXITCODE} != 0 ]; then
            echo failed EXITCODE = $EXITCODE sleeping...
            sleep $WAIT
	fi
    fi
done
exit $EXITCODE
