cmake_minimum_required(VERSION 3.17)

project(
    starterpp
    VERSION 1.0.0
    LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)

# By default build the release version with O3
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

message(STATUS "Using compiler ${CMAKE_CXX_COMPILER_ID} ...")

include(CMakeDependentOption)           # This is a really useful scripts that creates options that depends on other options. It can even be used with generator expressions !
include(GNUInstallDirs)                 # This will define the default values for installation directories (all platforms even if named GNU)
include(InstallRequiredSystemLibraries) # Tell CMake that the `install` target needs to install required system libraries (eg: Windows SDK)
include(CMakePackageConfigHelpers)      # Helper to create relocatable packages

# +----------------------------------------+
# | Options                                |
# +----------------------------------------+

option(STARTERPP_ENABLE_TEST "Should ${PROJECT_NAME} build the unit tests" ON)

# +----------------------------------------+
# | Dependencies                           |
# +----------------------------------------+

if(STARTERPP_ENABLE_TEST)
    include(GoogleTest)
    find_package(GTest REQUIRED)
    enable_testing()
endif()

find_package(Python3 COMPONENTS Interpreter Development.Module REQUIRED)
find_package(pybind11 CONFIG REQUIRED)
find_package(spdlog REQUIRED)

#############################################################
# Targets                                                   #
#############################################################

include_directories(${PROJECT_SOURCE_DIR}/src)
pybind11_add_module(starterpp src/starterpp.cc)
