add_library(status "")

target_sources(
    status
    PRIVATE
        status.cpp
    PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}/status.hpp
    )

target_include_directories(
    status
    PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}
    )

add_executable(status_reporter main.cpp)

target_link_libraries(
    status_reporter
    status
)