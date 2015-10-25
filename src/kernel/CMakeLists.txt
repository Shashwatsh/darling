project(darling-libsystem_kernel)

cmake_minimum_required(VERSION 2.4.0)

add_subdirectory(emulation/linux)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse -msse2 -msse3 -w -fblocks -ggdb")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__DARWIN_UNIX03 -fPIC -w -nostdinc")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -nostdlib -Wl,--version-script=${DARLING_TOP_DIRECTORY}/darwin.map")

if(CMAKE_SIZEOF_VOID_P EQUAL 4 OR CMAKE_INSTALL_LIBDIR STREQUAL "lib32")
	set(BITS 32)
	add_definitions(-DTARGET_CPU_X86=1)
else(CMAKE_SIZEOF_VOID_P EQUAL 4 OR CMAKE_INSTALL_LIBDIR STREQUAL "lib32")
	set(BITS 64)
	add_definitions(-DTARGET_CPU_X86_64=1)
endif(CMAKE_SIZEOF_VOID_P EQUAL 4 OR CMAKE_INSTALL_LIBDIR STREQUAL "lib32")

include_directories(${DARLING_TOP_DIRECTORY}/kernel-include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_definitions(-DTARGET_OS_MAC=1)
add_definitions(-DHAVE_STDINT_H=1)
add_definitions(-D__APPLE__ -D__DYNAMIC__)

add_subdirectory(libsyscall)
add_subdirectory(mach_server/client)

add_library(system_kernel SHARED
	$<TARGET_OBJECTS:libsyscall>
	$<TARGET_OBJECTS:kqueue>
	$<TARGET_OBJECTS:emulation>
	$<TARGET_OBJECTS:mach_server_client>)
target_link_libraries(system_kernel system_duct)

add_dependencies(system_kernel migcom)