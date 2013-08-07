########################################################
# cmake file for building Marlin example Package
# @author Haddad Yacine 
CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
########################################################


# project name
PROJECT(Trivent)


# project version
SET( ${PROJECT_NAME}_VERSION_MAJOR 0 )
SET( ${PROJECT_NAME}_VERSION_MINOR 4 )
SET( ${PROJECT_NAME}_VERSION_PATCH 2 )



### DEPENDENCIES ############################################################

FIND_PACKAGE( ILCUTIL REQUIRED COMPONENTS ILCSOFT_CMAKE_MODULES )

# load default settings from ILCSOFT_CMAKE_MODULES
INCLUDE( ilcsoft_default_settings )


FIND_PACKAGE( Marlin 1.0 REQUIRED ) # minimum required Marlin version
INCLUDE_DIRECTORIES( ${Marlin_INCLUDE_DIRS} )
LINK_LIBRARIES( ${Marlin_LIBRARIES} )
ADD_DEFINITIONS( ${Marlin_DEFINITIONS} )

FIND_PACKAGE( ROOT REQUIRED ) # minimum required Marlin version
INCLUDE_DIRECTORIES( ${ROOT_INCLUDE_DIRS} )
LINK_LIBRARIES( ${ROOT_LIBRARIES} )
ADD_DEFINITIONS( ${ROOT_DEFINITIONS} )

### DOCUMENTATION ###########################################################

OPTION( INSTALL_DOC "Set to OFF to skip build/install Documentation" ON )

IF( INSTALL_DOC AND EXISTS "${PROJECT_SOURCE_DIR}/doc/CMakeLists.txt" )
    ADD_SUBDIRECTORY( ./doc )
ENDIF()


ADD_DEFINITIONS( "-Wall -ansi -pedantic" )
ADD_DEFINITIONS( "-Wno-long-long" )


MACRO( ADD_FASTSIM_PKG _input_dir )
  MESSAGE( STATUS "Including package: ${_input_dir}" )
  INCLUDE_DIRECTORIES( BEFORE ${_input_dir}/include )
  AUX_SOURCE_DIRECTORY( ${_input_dir}/src FastSim_srcs )
ENDMACRO()


ADD_FASTSIM_PKG(  ./SDHCALReco )
ADD_FASTSIM_PKG(  ./EventBuilder )

# display some variables and write them to cache
DISPLAY_STD_VARIABLES()

