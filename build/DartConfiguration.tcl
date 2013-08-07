# This file is configured by CMake automatically as DartConfiguration.tcl
# If you choose not to use CMake, this file may be hand configured, by
# filling in the required variables.


# Configuration directories and files
SourceDirectory: /home/hadddad/work/Trivent/trunk
BuildDirectory: /home/hadddad/work/Trivent/trunk/build

# Where to place the cost data store
CostDataFile: 

# Site is something like machine.domain, i.e. pragmatic.crd
Site: yacine

# Build name is osname-revision-compiler, i.e. Linux-2.4.2-2smp-c++
BuildName: Linux-c++

# Submission information
IsCDash: 
CDashVersion: 
QueryCDashVersion: 
DropSite: 
DropLocation: 
DropSiteUser: 
DropSitePassword: 
DropSiteMode: 
DropMethod: http
TriggerSite: 
ScpCommand: /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/scp

# Dashboard start time
NightlyStartTime: 00:00:00 EDT

# Commands for the build/test/submit cycle
ConfigureCommand: "/home/hadddad/work/ilcsoft/v01-17-02/CMake/2.8.5/bin/cmake" "/home/hadddad/work/Trivent/trunk"
MakeCommand: /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/gmake -i
DefaultCTestConfigurationType: Release

# CVS options
# Default is "-d -P -A"
CVSCommand: CVSCOMMAND-NOTFOUND
CVSUpdateOptions: -d -A -P

# Subversion options
SVNCommand: /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/svn
SVNUpdateOptions: 

# Git options
GITCommand: /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/git
GITUpdateOptions: 
GITUpdateCustom: 

# Generic update command
UpdateCommand: /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/git
UpdateOptions: 
UpdateType: git

# Compiler info
Compiler: /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/c++

# Dynamic analysis and coverage
PurifyCommand: 
ValgrindCommand: 
ValgrindCommandOptions: 
MemoryCheckCommand: /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/valgrind
MemoryCheckCommandOptions: 
MemoryCheckSuppressionFile: 
CoverageCommand: /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/gcov

# Cluster commands
SlurmBatchCommand: SLURM_SBATCH_COMMAND-NOTFOUND
SlurmRunCommand: SLURM_SRUN_COMMAND-NOTFOUND

# Testing options
# TimeOut is the amount of time in seconds to wait for processes
# to complete during testing.  After TimeOut seconds, the
# process will be summarily terminated.
# Currently set to 25 minutes
TimeOut: 1500

UseLaunchers: 
CurlOptions: 
# warning, if you add new options here that have to do with submit,
# you have to update cmCTestSubmitCommand.cxx

# For CTest submissions that timeout, these options
# specify behavior for retrying the submission
CTestSubmitRetryDelay: 5
CTestSubmitRetryCount: 3
