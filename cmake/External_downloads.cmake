# Boost
set(boost_version 1.58.0)
string( REPLACE "." "_" boost_version_underscore ${boost_version} )
set(boost_url "http://sourceforge.net/projects/boost/files/boost/${boost_version}/boost_${boost_version_underscore}.tar.gz")
set(boost_md5 "5a5d5614d9a07672e1ab2a250b5defc5")

# List of externally downloaded source
set(external_sources boost)

# Iterate through our URLs, and create local filenames
foreach(source ${external_sources})
  set(url ${${source}_url})
  string(REGEX MATCH "[^/]*$" fname "${url}")
  if(NOT "${fname}" MATCHES "\\.(tar|bz2|zip|tgz|tar\\.gz)$")
    message(FATAL_ERROR "Could not extract tarball filename from url:\n ${url}")
  endif()
  if(EXISTS "${vector_download_dir}/${fname}")
    message(STATUS "Using tarball from source directory: ${fname}")
    set(${source}_file "${vector_download_dir}/${fname}")
  else()
    message(STATUS "Downloading file at build time: ${fname}")
    set(${source}_file ${${source}_url})
  endif()
  set(${source}_filename ${fname})
#   list(APPEND vector_files ${fname})
endforeach()