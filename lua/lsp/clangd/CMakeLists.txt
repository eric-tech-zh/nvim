cmake_minimum_required(VERSION 3.10)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(MyProject)

add_executable(MyExecutable)

file(GLOB_RECURSE SRC_LIST "*.cc" "*.cpp" "*.c")

target_sources(MyExecutable PRIVATE ${SRC_LIST})

file(GLOB_RECURSE SUBDIRS LIST_DIRECTORIES true "${CMAKE_CURRENT_SOURCE_DIR}/*")

foreach(subdir ${SUBDIRS})
    if(IS_DIRECTORY ${subdir})
        target_include_directories(MyExecutable PRIVATE ${subdir})
    endif()
endforeach()
