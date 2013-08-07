import sys
import os
import string

os.system('rm file.txt')
os.system('lfc-ls /grid/calice/haddad/DATA/trivent_output')
os.system('lfc-ls /grid/calice/haddad/DATA/trivent_output > file.txt')

runs = ['715493','715531']

ins = open( "file.txt", "r" )
array = []

for line in ins:
    ar  = []
    ar.append( line.strip() )
    array.append(ar)
print array



array2 = [] 
for index in array:
    for s in index:
        split_list = s.split("_")
        for run in runs: 
            if run in split_list:
                args = []
                args.append(s)
                array2.append(args)
                print args
                
print "==== find flowing file  ====="                
print array2




