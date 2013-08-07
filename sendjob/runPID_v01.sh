#!/bin/sh

date

uname -a

#Use the LCG file catalog (LFC)
export LCG_CATALOG_TYPE=lfc
export LFC_HOST=grid-lfc.desy.de
export VO_CALICE_DEFAULT_SE=dcache-se-desy.desy.de


ARCH=x86_64_gcc41_sl5

OUTDIR=/grid/calice/haddad/DHCALPid/output
INPUTDIR=/grid/calice/SDHCAL/TB/CERN/SPS_May2012/TRIVENT


echo VO_ILC_SW_DIR $VO_ILC_SW_DIR

ls -l ${VO_ILC_SW_DIR}
ls -l ${VO_ILC_SW_DIR}/ilcsoft/
ls -l ${VO_ILC_SW_DIR}/ilcsoft/${ARCH}
ls -l ${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/init_ilcsoft.sh

more ${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/init_ilcsoft.sh

source ${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/init_ilcsoft.sh v01-14



echo "getting careful down/uploaders..."

#lfc-cp ./run.xml

lcg-cp lfn:/grid/calice/jeans/carefulDownload.sh file:./carefulDownload.sh
lcg-cp lfn:/grid/calice/jeans/carefulUpload.sh file:./carefulUpload.sh

if [ ! -f ./carefulDownload.sh ]; then
    echo failed to get downloader
    exit 1
fi

if [ ! -f ./carefulUpload.sh ]; then
    echo failed to get uploader
    exit 1
fi

chmod u+x carefulUpload.sh
chmod u+x carefulDownload.sh

carefulDownload.sh DHCAL_714425_I0_0.slcio $INPUTDIR

carefulDownload.sh run.xml /grid/calice/haddad/DHCALPid
carefulDownload.sh libfindpid.so /grid/calice/haddad/DHCALPid

echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=${PWD}:${LD_LIBRARY_PATH}
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
export PATH=$PWD:$PATH

#export MARLIN="${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/Marlin"
export PATH=${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/bin:$PATH

export MARLIN_DLL=${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinReco.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libPandoraAnalysis.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinPandora.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCFIVertex.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libCEDViewer.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libOverlay.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libFastJetClustering.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinFastJet.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCTuple.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v00-01-02/lib/libMarlinKinfit.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinTrkProcessors.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libClupatra.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCFIPlus.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libForwardTracking.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinTPC.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libGarlic.so:$MARLIN_DLL

export MARLIN_DLL=$PWD/libfindpid.so:$MARLIN_DLL

echo "time before running"
date

Marlin run.xml

echo "time after running"
date

ls -l

./carefulUpload.sh pid_P15_714425.root $OUTDIR
./carefulUpload.sh pid_p15_714425.slcio $OUTDIR

exit 0
