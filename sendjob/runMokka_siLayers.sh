#!/bin/sh

date

uname -a

#Use the LCG file catalog (LFC)
export LCG_CATALOG_TYPE=lfc
export LFC_HOST=grid-lfc.desy.de
export VO_CALICE_DEFAULT_SE=dcache-se-desy.desy.de


ARCH=x86_64_gcc41_sl5

OUTDIR=/grid/calice/haddad/DHCALPid/output
SPS_INPUTDIR=/grid/calice/SDHCAL/TB/CERN/SPS_May2012/TRIVENT
PS_INPUTDIR=/grid/calice/SDHCAL/TB/CERN/PS_April2012/TRIVENT


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

carefulDownload.sh DHCAL_713983_I0_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_713983_I1_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_713983_I3_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_713983_I4_0.slcio $PS_INPUTDIR

carefulDownload.sh DHCAL_714080_I0_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_714080_I1_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_714080_I3_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_714080_I4_0.slcio $PS_INPUTDIR

carefulDownload.sh DHCAL_714085_I0_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_714085_I1_1.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_714085_I2_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_714085_I2_1.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_714085_I3_0.slcio $PS_INPUTDIR
carefulDownload.sh DHCAL_714085_I3_1.slcio $PS_INPUTDIR
#
carefulDownload.sh DHCAL_714425_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714425_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714425_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714425_I3_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714425_I4_0.slcio $SPS_INPUTDIR
#
#carefulDownload.sh DHCAL_714565_I0_0.slcio $SPS_INPUTDIR
#carefulDownload.sh DHCAL_714565_I1_0.slcio $SPS_INPUTDIR
#carefulDownload.sh DHCAL_714565_I3_0.slcio $SPS_INPUTDIR
#
carefulDownload.sh DHCAL_714562_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714562_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714562_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714562_I3_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714556_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714556_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714556_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714556_I3_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714551_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714551_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714551_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714551_I3_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714553_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714553_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714553_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714553_I3_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714520_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714520_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714520_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714520_I3_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714520_I4_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714536_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714536_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714536_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714536_I3_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714541_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714541_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714541_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714541_I3_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714541_I4_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714547_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714547_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714547_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714547_I3_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714470_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714470_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714470_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714470_I3_0.slcio $SPS_INPUTDIR

# e-
carefulDownload.sh DHCAL_714476_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714476_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714476_I2_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714476_I3_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714476_I4_0.slcio $SPS_INPUTDIR

carefulDownload.sh DHCAL_714474_I0_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714474_I1_0.slcio $SPS_INPUTDIR
carefulDownload.sh DHCAL_714474_I3_0.slcio $SPS_INPUTDIR


#carefulDownload.sh run.xml /grid/calice/haddad/DHCALPid
carefulDownload.sh run_p15_714425.xml /grid/calice/haddad/DHCALPid
#carefulDownload.sh run_p20_714565.xml /grid/calice/haddad/DHCALPid
carefulDownload.sh run_p30_714562.xml /grid/calice/haddad/DHCALPid
carefulDownload.sh run_p40_714556.xml /grid/calice/haddad/DHCALPid
carefulDownload.sh run_p50_714551-53.xml /grid/calice/haddad/DHCALPid
carefulDownload.sh run_p70_714520-36-41-47.xml /grid/calice/haddad/DHCALPid
carefulDownload.sh run_p80_714470.xml /grid/calice/haddad/DHCALPid

carefulDownload.sh run_e30_714476.xml /grid/calice/haddad/DHCALPid
carefulDownload.sh run_e15_714474.xml /grid/calice/haddad/DHCALPid


carefulDownload.sh libDHCALPid.so /grid/calice/haddad/DHCALPid

echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=${PWD}:${LD_LIBRARY_PATH}
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
export PATH=$PWD:$PATH

#export MARLIN="${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/Marlin"
export PATH=${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/bin:$PATH

export MARLIN_DLL=${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinReco.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libPandoraAnalysis.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinPandora.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCFIVertex.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libCEDViewer.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libOverlay.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libFastJetClustering.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinFastJet.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCTuple.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinTrkProcessors.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libClupatra.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCFIPlus.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libForwardTracking.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinTPC.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libGarlic.so:$MARLIN_DLL

export MARLIN_DLL=$PWD/libDHCALPid.so:$MARLIN_DLL

echo "time before running"
date


echo "====electron runs ==="

Marlin run_e30_714476.xml
Marlin run_e15_714474.xml

echo "====pion     runs ==="
Marlin run_p15_714425.xml
#Marlin run_p20_714565.xml
Marlin run_p30_714562.xml
Marlin run_p40_714556.xml
Marlin run_p50_714551-53.xml
Marlin run_p70_714520-36-41-47.xml
Marlin run_p80_714470.xml


echo "time after running"
date

ls -l

#./carefulUpload.sh pid_p15_714565.root $OUTDIR
#./carefulUpload.sh pid_p15_714565.slcio $OUTDIR

STORAGE_SITE=polgrid4.in2p3.fr
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p15_714425.root file:./pid_p15_714425.root
#lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p20_714565.root file:./pid_p20_714565.root
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p30_714562.root file:./pid_p30_714562.root
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p40_714556.root file:./pid_p40_714556.root
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p50_714551-53.root file:./pid_p50_714551-53.root
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p70_714520-36-41-47.root file:./pid_p70_714520-36-41-47.root
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p80_714470.root file:./pid_p80_714470.root

lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_e15_714474.root file:./pid_e15_714474.root
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_e30_714476.root file:./pid_e30_714476.root
#======================================================
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p15_714425.slcio file:./pid_p15_714425.slcio
#lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p20_714565.slcio file:./pid_p20_714565.slcio
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p30_714562.slcio file:./pid_p30_714562.slcio
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p40_714556.slcio file:./pid_p40_714556.slcio
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p50_714551-53.slcio file:./pid_p50_714551-53.slcio
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p70_714520-36-41-47.slcio file:./pid_p70_714520-36-41-47.slcio
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_p80_714470.slcio file:./pid_p80_714470.slcio

lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_e15_714474.slcio file:./pid_e15_714474.slcio
lcg-cr -d $STORAGE_SITE -v --vo calice -l lfn:$OUTDIR/pid_e30_714476.slcio file:./pid_e30_714476.slcio


exit 0
