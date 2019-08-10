set(SUBPROJECT_NAME status)

list(APPEND ${SUBPROJECT_NAME}_DEPENDS
    ${BOOST_TARGET}
    # ${GTEST_TARGET}
)
set(${SUBPROJECT_NAME}_BUILD_ARGS
    ${build_vars}
    # ${gtest_build_vars}
)
   

ExternalProject_Add(${SUBPROJECT_NAME}
      PREFIX "${SP_BINARY_DIR}/${SUBPROJECT_NAME}"
      SOURCE_DIR ${SUBPROJECT_NAME}
      CMAKE_CACHE_ARGS
        ${${SUBPROJECT_NAME}_BUILD_ARGS}
      DEPENDS 
        ${${SUBPROJECT_NAME}_DEPENDS}
    )