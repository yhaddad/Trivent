# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canoncical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/hadddad/work/ilcsoft/v01-17-02/CMake/2.8.5/bin/cmake

# The command to remove a file.
RM = /home/hadddad/work/ilcsoft/v01-17-02/CMake/2.8.5/bin/cmake -E remove -f

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /home/hadddad/work/ilcsoft/v01-17-02/CMake/2.8.5/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/hadddad/work/Trivent/trunk

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/hadddad/work/Trivent/trunk/build

# Utility rule file for doc.

doc/CMakeFiles/doc: docbuild/html/index.html

docbuild/html/index.html: ../doc/Doxyfile
docbuild/html/index.html: ../doc/CMakeLists.txt
docbuild/html/index.html: ../doc/../EventBuilder/include/*
docbuild/html/index.html: ../doc/../EventBuilder/src/*
	$(CMAKE_COMMAND) -E cmake_progress_report /home/hadddad/work/Trivent/trunk/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Building API Documentation..."
	cd /home/hadddad/work/Trivent/trunk/doc && DOX_PROJECT_NAME=Trivent DOX_PROJECT_NUMBER="0.4.2" DOX_OUTPUT_DIRECTORY="/home/hadddad/work/Trivent/trunk/build/docbuild" DOX_INPUT="../EventBuilder/include ../EventBuilder/src" /home/hadddad/work/ilcsoft/v01-17-02/gsl/usr/bin/doxygen

doc: doc/CMakeFiles/doc
doc: docbuild/html/index.html
doc: doc/CMakeFiles/doc.dir/build.make
.PHONY : doc

# Rule to build all files generated by this target.
doc/CMakeFiles/doc.dir/build: doc
.PHONY : doc/CMakeFiles/doc.dir/build

doc/CMakeFiles/doc.dir/clean:
	cd /home/hadddad/work/Trivent/trunk/build/doc && $(CMAKE_COMMAND) -P CMakeFiles/doc.dir/cmake_clean.cmake
.PHONY : doc/CMakeFiles/doc.dir/clean

doc/CMakeFiles/doc.dir/depend:
	cd /home/hadddad/work/Trivent/trunk/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/hadddad/work/Trivent/trunk /home/hadddad/work/Trivent/trunk/doc /home/hadddad/work/Trivent/trunk/build /home/hadddad/work/Trivent/trunk/build/doc /home/hadddad/work/Trivent/trunk/build/doc/CMakeFiles/doc.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : doc/CMakeFiles/doc.dir/depend

