import os
import sys 
import string


runs = ['']
    
os.system('rm file.txt')
os.system('lfc-ls /grid/calice/SDHCAL/TB/CERN/SPS_AugSep2012/RAW')
os.system('lfc-ls /grid/calice/SDHCAL/TB/CERN/SPS_AugSep2012/RAW > file.txt')

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
                cmd = './carefulDownload.sh'+' '+ss+' '+'/grid/calice/SDHCAL/TB/CERN/SPS_AugSep2012/RAW'
                os.system(cmd)
print "==== find flowing file  ====="       
print gs
