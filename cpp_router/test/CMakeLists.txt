enable_testing()
find_package(GTest)

add_executable(
    test_router
    test_router.cpp
    )

target_link_libraries(
    test_router
    GTest::GTest 
    GTest::Main
    router
    )

add_test(
  NAME
    unit
  COMMAND
    ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}/test_router
  )