cmake_minimum_required(VERSION 3.7)
project(SP)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_MODULE_PATH "${SP_SOURCE_DIR}/cmake")

include(ExternalProject)
include(External_downloads)
include(External_boost)

include(Project_status)