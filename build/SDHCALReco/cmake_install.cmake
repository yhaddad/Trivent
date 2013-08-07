# Install script for directory: /home/hadddad/work/Trivent/trunk/SDHCALReco

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/home/hadddad/work/Trivent/trunk")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE DIRECTORY FILES "/home/hadddad/work/Trivent/trunk/SDHCALReco/./include" FILES_MATCHING REGEX "/[^/]*\\.h$" REGEX "/[^/]*\\~$" EXCLUDE REGEX "/[^/]*\\#[^/]*$" EXCLUDE REGEX "/\\.\\#[^/]*$" EXCLUDE REGEX "/[^/]*CVS$" EXCLUDE REGEX "/[^/]*\\.svn$" EXCLUDE)
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE DIRECTORY FILES "/home/hadddad/work/Trivent/trunk/SDHCALReco/./include" FILES_MATCHING REGEX "/[^/]*\\.hh$" REGEX "/[^/]*\\~$" EXCLUDE REGEX "/[^/]*\\#[^/]*$" EXCLUDE REGEX "/\\.\\#[^/]*$" EXCLUDE REGEX "/[^/]*CVS$" EXCLUDE REGEX "/[^/]*\\.svn$" EXCLUDE)
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FOREACH(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTriventReco.so.0.4.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTriventReco.so.0.4"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTriventReco.so"
      )
    IF(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      FILE(RPATH_CHECK
           FILE "${file}"
           RPATH "/home/hadddad/work/Trivent/trunk/lib:/home/hadddad/work/ilcsoft/v01-17-02/Marlin/v01-05/lib:/home/hadddad/work/ilcsoft/v01-17-02/lcio/v02-04-01/lib:/home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/lib/x86_64-linux-gnu:/home/hadddad/work/ilcsoft/v01-17-02/gear/v01-03/lib:/home/hadddad/work/ilcsoft/v01-17-02/CLHEP/2.1.3.1/lib:/home/hadddad/work/ilcsoft/v01-17-02/ilcutil/v01-00/lib:/home/hadddad/work/ilcsoft/v01-17-02/root/5.34.05/lib")
    ENDIF()
  ENDFOREACH()
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE FILES
    "/home/hadddad/work/Trivent/trunk/build/lib/libTriventReco.so.0.4.1"
    "/home/hadddad/work/Trivent/trunk/build/lib/libTriventReco.so.0.4"
    "/home/hadddad/work/Trivent/trunk/build/lib/libTriventReco.so"
    )
  FOREACH(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTriventReco.so.0.4.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTriventReco.so.0.4"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTriventReco.so"
      )
    IF(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      FILE(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/hadddad/work/ilcsoft/v01-17-02/Marlin/v01-05/lib:/home/hadddad/work/ilcsoft/v01-17-02/lcio/v02-04-01/lib:/home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/lib/x86_64-linux-gnu:/home/hadddad/work/ilcsoft/v01-17-02/gear/v01-03/lib:/home/hadddad/work/ilcsoft/v01-17-02/CLHEP/2.1.3.1/lib:/home/hadddad/work/ilcsoft/v01-17-02/ilcutil/v01-00/lib:/home/hadddad/work/ilcsoft/v01-17-02/root/5.34.05/lib:::::::::::::::::::::::::::::::::::::"
           NEW_RPATH "/home/hadddad/work/Trivent/trunk/lib:/home/hadddad/work/ilcsoft/v01-17-02/Marlin/v01-05/lib:/home/hadddad/work/ilcsoft/v01-17-02/lcio/v02-04-01/lib:/home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/lib/x86_64-linux-gnu:/home/hadddad/work/ilcsoft/v01-17-02/gear/v01-03/lib:/home/hadddad/work/ilcsoft/v01-17-02/CLHEP/2.1.3.1/lib:/home/hadddad/work/ilcsoft/v01-17-02/ilcutil/v01-00/lib:/home/hadddad/work/ilcsoft/v01-17-02/root/5.34.05/lib")
      IF(CMAKE_INSTALL_DO_STRIP)
        EXECUTE_PROCESS(COMMAND "/home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/strip" "${file}")
      ENDIF(CMAKE_INSTALL_DO_STRIP)
    ENDIF()
  ENDFOREACH()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

