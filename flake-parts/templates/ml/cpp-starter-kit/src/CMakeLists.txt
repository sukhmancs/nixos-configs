add_executable(what_time)
target_sources(what_time PRIVATE what_time.cc)
target_link_libraries(what_time PRIVATE absl::time spdlog::spdlog)

add_library(simple)
target_sources(simple
    PUBLIC
    $<INSTALL_INTERFACE:include/src/simple.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/simple.h>
    PRIVATE simple.cc)

if(ENABLE_TESTING)
    MAKE_CC_TEST(
        NAME simple_test
        SRCS simple_test.cc
        DEPS simple)
endif()
