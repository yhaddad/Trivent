import os
import sys
import string
from Ganga import *

scriptLocalPath = "./"

miphistScript = "run_trivent_grid.sh"
miphistPath   = "%s/%s" % (scriptLocalPath, miphistScript)

inbox = [miphistPath]

# CE = 'grid-ce5\.desy\.de:2119/jobmanager-lcgpbs-desy'
# CE = 'grid-cr5\.desy\.de:8443/cream-pbs-desy'

CE = 'grid-cr4\.desy\.de:8443/cream-pbs-desy'

# ecals = ['siOnly', 'scOnly', 'blocks', 'alternate']

#In [21:]
#In [22]:j = Job(splitter=s)
#In [23]:j.submit()


try:
    print "submitting job"
    s = ArgSplitter(args=[['DHCAL_715390_I0_0.slcio'],
                          ['DHCAL_715390_I3_2.slcio']])
    
#    s = ArgSplitter(args=[['DHCAL_715390_I0_0.slcio'],
#                          ['DHCAL_715390_I0_1.slcio'],
#                          ['DHCAL_715390_I0_2.slcio'],
#                          ['DHCAL_715390_I1_0.slcio'],
#                          ['DHCAL_715390_I1_1.slcio'],
#                          ['DHCAL_715390_I1_2.slcio'],
#                          ['DHCAL_715390_I2_0.slcio'],
#                          ['DHCAL_715390_I2_1.slcio'],
#                          ['DHCAL_715390_I2_2.slcio'],
#                          ['DHCAL_715390_I3_0.slcio'],
#                          ['DHCAL_715390_I3_1.slcio'],
#                          ['DHCAL_715390_I3_2.slcio']])
    j = Job(splitter=s)
    j.backend = LCG()
    j.backend.middleware = 'GLITE'
    j.backend.CE = CE
    j.name = 'test'
    j.application.exe = miphistScript
    args = ['arg1']
    j.application.args = args
    j.inputsandbox = inbox
    print j.application.exe, j.application.args, j.inputsandbox
    j.submit()
except:
    print "failed to submit job"
