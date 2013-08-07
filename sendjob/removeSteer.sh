#!/bin/sh

lcg-cp lfn:/grid/calice/jeans/carefulDownload.sh file:./carefulDownload.sh
lcg-cp lfn:/grid/calice/jeans/carefulUpload.sh file:./carefulUpload.sh

#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_e15_714474.xml
#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_e30_714476.xml
#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_p15_714425.xml
#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_p20_714565.xml
#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_p30_714562.xml
#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_p40_714556.xml
#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_p50_714551-53.xml
#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_p70_714520-36-41-47.xml
#lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/run_p80_714470.xml

lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_P15_714425.root
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_P15_714425.slcio
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_e15_714474.root
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_e15_714474.slcio
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_e30_714476.root
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_e30_714476.slcio
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p30_714562.root
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p30_714562.slcio
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p40_714556.root
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p40_714556.slcio
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p50_714551-53.root
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p50_714551-53.slcio
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p70_714520-36-41-47.root
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p70_714520-36-41-47.slcio
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p80_714470.root
lcg-del -a --vo calice lfn:/grid/calice/haddad/DHCALPid/output/pid_p80_714470.slcio

#./carefulUpload.sh run_p15_714425.xml          /grid/calice/haddad/DHCALPid
#./carefulUpload.sh run_p20_714565.xml          /grid/calice/haddad/DHCALPid
#./carefulUpload.sh run_p30_714562.xml          /grid/calice/haddad/DHCALPid
#./carefulUpload.sh run_p40_714556.xml          /grid/calice/haddad/DHCALPid
#./carefulUpload.sh run_p50_714551-53.xml       /grid/calice/haddad/DHCALPid
#./carefulUpload.sh run_p70_714520-36-41-47.xml /grid/calice/haddad/DHCALPid
#./carefulUpload.sh run_p80_714470.xml          /grid/calice/haddad/DHCALPid
#./carefulUpload.sh run_e30_714476.xml          /grid/calice/haddad/DHCALPid
#./carefulUpload.sh run_e15_714474.xml          /grid/calice/haddad/DHCALPid
#
#lfc-ls /grid/calice/haddad/DHCALPid/steer
