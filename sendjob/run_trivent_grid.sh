#!/bin/bash

echo "==================================================="

date 
uname -a

echo "============= Trivent parameters =================="

NRUN=$1
En=$2

GAIN_CORRECTION_MODE=false
electronic_noise_cut=100000
layerGap=2.8
LayerCut=7
noiseCut=7
timeWin=1
TBperiod=SPS_AugSep2012
#TBperiod=SPS_May2012
echo "==================================================="

export LCG_CATALOG_TYPE=lfc
export LFC_HOST=grid-lfc.desy.de
export VO_CALICE_DEFAULT_SE=dcache-se-desy.desy.de

ARCH=x86_64_gcc41_sl5


echo "================  raw run   ======================="
echo ${NRUN}
echo "==================================================="

INPUTDIR=/grid/calice/SDHCAL/TB/CERN/${TBperiod}/RAW
#OUTPUTDIR=/grid/calice/SDHCAL/TB/CERN/${TBperiod}/TRIVENT
OUTPUTDIR=/grid/calice/SDHCAL/haddad/Trivent_output/scan_threshold_aug
TRIVENTDIR=/grid/calice/haddad/Trivent_v0.3.1

echo "================  ILCSoft - ======================="

echo VO_ILC_SW_DIR $VO_ILC_SW_DIR
ls -l ${VO_ILC_SW_DIR}
ls -l ${VO_ILC_SW_DIR}/ilcsoft/
ls -l ${VO_ILC_SW_DIR}/ilcsoft/${ARCH}
ls -l ${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/init_ilcsoft.sh

more ${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/init_ilcsoft.sh
source ${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/init_ilcsoft.sh v01-14

echo "===  getting careful down/uploaders... ==========="

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

echo "===  uploading the libraries & geometry =========="

carefulDownload.sh libTrivent.so ${TRIVENTDIR}
carefulDownload.sh Slot1_39_MARLIN.txt ${TRIVENTDIR}
carefulDownload.sh can37.xml ${TRIVENTDIR}

echo "===  getting the file from the grid... ==========="
cat > getfile.py <<EOF
import os
import sys 
import string


runs = ['${NRUN}']
    
os.system('rm file.txt')
#os.system('lfc-ls /grid/calice/SDHCAL/TB/CERN/SPS_May2012/STREAMOUT')
#os.system('lfc-ls /grid/calice/SDHCAL/TB/CERN/SPS_May2012/STREAMOUT > file.txt')
os.system('lfc-ls /grid/calice/SDHCAL/TB/CERN/${TBperiod}/RAW')
os.system('lfc-ls /grid/calice/SDHCAL/TB/CERN/${TBperiod}/RAW > file.txt')

ins = open( "file.txt", "r" )
array = []

for line in ins:
    ar  = []
    ar.append( line.strip() )
    array.append(ar)
#print array
    
gs = []
for index in array:
    for ss in index:
        split_list = ss.split("_")
        for run in runs:
            if run in split_list:
                print ss
                cmd = './carefulDownload.sh'+' '+ss+' '+'/grid/calice/SDHCAL/TB/CERN/${TBperiod}/RAW'
                os.system(cmd)
print "==== find flowing file  ====="       
print gs
EOF
python getfile.py 

echo "===  source the environement on grid.. ==========="

echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=${PWD}:${LD_LIBRARY_PATH}
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
export PATH=$PWD:$PATH
export PATH=${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/bin:$PATH
export MARLIN_DLL=${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinReco.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libPandoraAnalysis.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinPandora.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCFIVertex.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libCEDViewer.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libOverlay.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libFastJetClustering.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinFastJet.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCTuple.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinTrkProcessors.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libClupatra.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libLCFIPlus.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libForwardTracking.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libMarlinTPC.so:${VO_ILC_SW_DIR}/ilcsoft/${ARCH}/v01-14/lib/libGarlic.so:$MARLIN_DLL

export MARLIN_DLL=$PWD/libTrivent.so:$MARLIN_DLL

echo "========  steering file for Marlin ============="

cat >LCIO.xml<<EOF
<marlin>
  <!--##########################################
      #                                        #
      #     Steering file for Trivent_beta     #
      #                                        #
      ##########################################-->
  <execute>
    <processor name="MySDHCAL_RawData_Processor"/>
    <processor name="MyTriventProc"/>
  </execute>
  
  <global>
    <parameter name="LCIOInputFiles">
EOF


for file in *.slcio
do    
    echo "      ${file}"
    echo "      ${file}" >>LCIO.xml
done

cat > LCIO_suite.xml <<EOF
    </parameter>
    <!--parameter name="MaxRecordNumber" value="10"/-->
    <parameter name="SkipNEvents" value="0"/>
    <parameter name="SupressCheck" value="false"/>
  </global>
  <processor name="MySDHCAL_RawData_Processor" type="SDHCAL_RawData_Processor">
    <!--SDHCAL_RawData_Processor prints info on the Raw data-->
    <!--verbosity level of this processor ("DEBUG0-4,MESSAGE0-4,WARNING0-4,ERROR0-4,SILENT")-->
    <parameter name="Verbosity" type="string">DEBUG </parameter>
    <!--parameter name="Verbosity" type="string">MESSAGE </parameter-->
    <!--XDAQ produced collection name-->
    
    <parameter name="XDAQCollectionName" type="string" lcioInType="LCGenericObject">RU_XDAQ </parameter>
    <!--Name of output collection containing raw calorimeter hits-->
    <parameter name="OutputRawCaloHitCollectionName" type="string" lcioOutType="RawCalorimeterHit">DHCALRawHits </parameter>
    <!--Turn ON/OFF debug mode : Warning Debug mode uses assert and may crash the application-->
    <parameter name="DebugMode" type="bool"> false </parameter>
  </processor>

  <processor name="MyTriventProc" type="TriventProc">
    <parameter name="DIFMapping" type="string">
      ./Slot1_39_MARLIN.txt
    </parameter>
    <parameter name="setup_geometry" type="string"> ./can37.xml </parameter>
    <parameter name="HitCollectionName" type="StringVec">DHCALRawHits </parameter>
    <parameter name="GAIN_CORRECTION_MODE" type="bool">${GAIN_CORRECTION_MODE}</parameter>
    <parameter name="electronic_noise_cut" type="int">${electronic_noise_cut}</parameter>
    <parameter name="layerGap" type="double"> ${layerGap} </parameter>
    <parameter name="LayerCut" type="int"> ${LayerCut} </parameter>
    <parameter name="noiseCut" type="int"> ${noiseCut} </parameter>
    <parameter name="timeWin" type="int"> ${timeWin} </parameter>
    <parameter name="beamEnergy" type="float">${En} </parameter>
    <parameter name="LCIOOutputFile" value="./TDHCAL_${NRUN}.slcio"/>
  </processor>
  <processor name="MyLCIOOutputProcessor" type="LCIOOutputProcessor">
    <parameter name="LCIOWriteMode" type="string">WRITE_NEW </parameter>
  </processor>
  
</marlin>


EOF
cat LCIO_suite.xml >>LCIO.xml
echo "========  RUNNING TRIVENT RECO ================="

Marlin LCIO.xml

echo " Marlin has run with the following xml :"
cat LCIO.xml

echo "========  Upload file on my home ==============="
ls -ltr

./carefulUpload.sh TDHCAL_${NRUN}.slcio $OUTPUTDIR

#rm -rf *.slcio
