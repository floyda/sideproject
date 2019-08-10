# -----------------------------------------------------
# External project to extract, configure, and build
# Boost libraries from source.
# -----------------------------------------------------

set(boost_external_project "boost_${boost_version_underscore}")
set(boost_config_command   
    ./bootstrap.sh 
    --with-libraries=atomic,filesystem,system,thread,regex,date_time,program_options,signals,random)

if( CMAKE_TOOLCHAIN_FILE )
file(WRITE $ENV{HOME}/user-config.jam "using gcc : toolchain : ${CMAKE_CXX_COMPILER} ;")
set(boost_build_command    ./b2 toolset=gcc-toolchain)
else()
set(boost_build_command    ./b2)
endif()

message("boost build_command: ${boost_build_command}")

ExternalProject_Add(${boost_external_project}
    PREFIX "${CMAKE_CURRENT_BINARY_DIR}/boost"
    URL ${boost_file}
    URL_MD5 ${boost_md5}
    BUILD_IN_SOURCE 1
    PATCH_COMMAND patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/cmake/boost_1_58_0-ThreadFutureWarning.patch
    CONFIGURE_COMMAND ${boost_config_command}
    BUILD_COMMAND ${boost_build_command}
    INSTALL_COMMAND ""
)

ExternalProject_Get_Property(${boost_external_project} source_dir)
set(BOOST_ROOT ${source_dir})
set(BOOST_TARGET ${boost_external_project})

