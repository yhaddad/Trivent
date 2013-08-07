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

#CE = 'grid-cr4\.desy\.de:8443/cream-pbs-desy'
CE = 'grid-cr3.desy.de:8443/cream-pbs-desy'
###CE = 'llrcream.in2p3.fr:8443/cream-pbs-calice,grid36.lal.in2p3.fr:8443/cream-pbs-calice'
#CE = ['llrcream.in2p3.fr:8443/cream-pbs-calice','grid36.lal.in2p3.fr:8443/cream-pbs-calice']
# ecals = ['siOnly', 'scOnly', 'blocks', 'alternate']
# read a input files 

# ----------
#In [21:]
#In [22]:j = Job(splitter=s)
#In [23]:j.submit()
#runs = ['714520','714536','714541','714547','714470']
try:
    print "submitting job"
    print "==== find flowing file  ====="
    #    runs = [['715611','0'],['715571','0'],['715411','0']]               
    #    runs = [['714408','0']]               
#    runs = [['715694','5'],
    runs = [['715695','7.5'],
#            ['715693','10'] ,
            #            ['715692','10'] ,
            #            ['715675','20'] ,
            ['715671','30']]# ,
    #            ['715651','40'] ,
    #            ['715612','50'] ,
    #            ['715596','50'] ,
    #            ['715595','50'] ,
    #            ['715594','50'] ,
    #            ['715593','50'] ,
    #            ['715551','50'] ,
    #            ['715531','60'] ,
    #            ['715511','60'] ,
    #            ['715493','70'] ,
    #            ['715491','80'] ,
    #            ['715480','80']]
    #  scan threshold
    #runs = [['715763','30'],
    #        ['715764','30'],
    #        ['715765','30'],
    #        ['715766','30'],
    #        ['715767','30'],
    #        ['715768','30'],
    #        ['715768','30'],
    #        ['715769','30'],
    #        ['715770','30'],
    #        ['715771','30'],
    #        ['715772','30'],
    #        ['715773','30'],
    #        ['715774','30'],
    #        ['715775','30'],
    #        ['715776','30'],
    #        ['715777','30'],
    #        ['715778','30'],
    #        ['715779','30'],
    #        ['715780','30'],
    #        ['715781','30'],
    #        ['715782','30'],
    #        ['715783','30'],
    #        ['715784','30'],
    #        ['715785','30'],
    #        ['715786','30'],
    #        ['715787','30']]               
    print runs;
    s = ArgSplitter(args=runs)
    print "==== after argSplitter ======"
    
    print s
    j = Job(splitter=s)
    j.backend = LCG()
    j.backend.middleware = 'GLITE'
    j.backend.CE = CE
    j.name = 'thr scan'
    j.application.exe = miphistScript
    args = ['arg1','arg2']
    j.application.args = args
    j.inputsandbox = inbox
    print j.application.exe, j.application.args, j.inputsandbox
    j.submit()
except:
    print "failed to submit job"
