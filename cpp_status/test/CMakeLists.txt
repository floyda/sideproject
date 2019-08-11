enable_testing()
find_package(GTest)

add_executable(
    test_status
    test_status.cpp
    )

target_link_libraries(
    test_status
    GTest::GTest 
    GTest::Main
    status
    )

add_test(
  NAME
    unit
  COMMAND
    ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}/test_status
  )