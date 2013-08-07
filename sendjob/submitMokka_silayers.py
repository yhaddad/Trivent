import os
import sys
import string
from Ganga import *

scriptLocalPath = "./"

miphistScript = "runMokka_siLayers.sh"
miphistPath   = "%s/%s" % (scriptLocalPath, miphistScript)

inbox = [miphistPath]

# CE = 'grid-ce5\.desy\.de:2119/jobmanager-lcgpbs-desy'
# CE = 'grid-cr5\.desy\.de:8443/cream-pbs-desy'

CE = 'grid-cr4\.desy\.de:8443/cream-pbs-desy'

# ecals = ['siOnly', 'scOnly', 'blocks', 'alternate']



try:
    print "submitting job"
    j = Job()
    j.backend = LCG()
    j.backend.middleware = 'GLITE'
    j.backend.CE = CE
    j.name = 'test'
    j.application.exe = miphistScript
    args = ""
    j.application.args = args
    j.inputsandbox = inbox
    print j.application.exe, j.application.args, j.inputsandbox
    j.submit()
except:
    print "failed to submit job"
