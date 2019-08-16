add_library(router "")

target_sources(
    router
    PRIVATE
        router.cpp
    PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}/router.hpp
    )

target_include_directories(
    router
    PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}
    )

add_executable(wamp_router main.cpp)

target_link_libraries(
    wamp_router
    router
    wampcc
)