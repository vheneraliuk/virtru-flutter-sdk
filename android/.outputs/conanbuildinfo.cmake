include(CMakeParseArguments)

macro(conan_find_apple_frameworks FRAMEWORKS_FOUND FRAMEWORKS SUFFIX BUILD_TYPE)
    if(APPLE)
        if(CMAKE_BUILD_TYPE)
            set(_BTYPE ${CMAKE_BUILD_TYPE})
        elseif(NOT BUILD_TYPE STREQUAL "")
            set(_BTYPE ${BUILD_TYPE})
        endif()
        if(_BTYPE)
            if(${_BTYPE} MATCHES "Debug|_DEBUG")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "Release|_RELEASE")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "RelWithDebInfo|_RELWITHDEBINFO")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "MinSizeRel|_MINSIZEREL")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            endif()
        endif()
        foreach(_FRAMEWORK ${FRAMEWORKS})
            # https://cmake.org/pipermail/cmake-developers/2017-August/030199.html
            find_library(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND NAMES ${_FRAMEWORK} PATHS ${CONAN_FRAMEWORK_DIRS${SUFFIX}} CMAKE_FIND_ROOT_PATH_BOTH)
            if(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND)
                list(APPEND ${FRAMEWORKS_FOUND} ${CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND})
            else()
                message(FATAL_ERROR "Framework library ${_FRAMEWORK} not found in paths: ${CONAN_FRAMEWORK_DIRS${SUFFIX}}")
            endif()
        endforeach()
    endif()
endmacro()


#################
###  PYBIND11
#################
set(CONAN_PYBIND11_ROOT "/Users/vheneraliuk/.conan/data/pybind11/2.10.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_PYBIND11 "/Users/vheneraliuk/.conan/data/pybind11/2.10.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_PYBIND11 "/Users/vheneraliuk/.conan/data/pybind11/2.10.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib")
set(CONAN_BIN_DIRS_PYBIND11 )
set(CONAN_RES_DIRS_PYBIND11 )
set(CONAN_SRC_DIRS_PYBIND11 )
set(CONAN_BUILD_DIRS_PYBIND11 "/Users/vheneraliuk/.conan/data/pybind11/2.10.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/cmake/pybind11")
set(CONAN_FRAMEWORK_DIRS_PYBIND11 )
set(CONAN_LIBS_PYBIND11 )
set(CONAN_PKG_LIBS_PYBIND11 )
set(CONAN_SYSTEM_LIBS_PYBIND11 )
set(CONAN_FRAMEWORKS_PYBIND11 )
set(CONAN_FRAMEWORKS_FOUND_PYBIND11 "")  # Will be filled later
set(CONAN_DEFINES_PYBIND11 )
set(CONAN_BUILD_MODULES_PATHS_PYBIND11 )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_PYBIND11 )

set(CONAN_C_FLAGS_PYBIND11 "")
set(CONAN_CXX_FLAGS_PYBIND11 "")
set(CONAN_SHARED_LINKER_FLAGS_PYBIND11 "")
set(CONAN_EXE_LINKER_FLAGS_PYBIND11 "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_PYBIND11_LIST "")
set(CONAN_CXX_FLAGS_PYBIND11_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_PYBIND11_LIST "")
set(CONAN_EXE_LINKER_FLAGS_PYBIND11_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_PYBIND11 "${CONAN_FRAMEWORKS_PYBIND11}" "_PYBIND11" "")
# Append to aggregated values variable
set(CONAN_LIBS_PYBIND11 ${CONAN_PKG_LIBS_PYBIND11} ${CONAN_SYSTEM_LIBS_PYBIND11} ${CONAN_FRAMEWORKS_FOUND_PYBIND11})


#################
###  OPENTDF-CLIENT
#################
set(CONAN_OPENTDF-CLIENT_ROOT "/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd")
set(CONAN_INCLUDE_DIRS_OPENTDF-CLIENT "/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/include")
set(CONAN_LIB_DIRS_OPENTDF-CLIENT "/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/lib")
set(CONAN_BIN_DIRS_OPENTDF-CLIENT )
set(CONAN_RES_DIRS_OPENTDF-CLIENT )
set(CONAN_SRC_DIRS_OPENTDF-CLIENT )
set(CONAN_BUILD_DIRS_OPENTDF-CLIENT "/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/")
set(CONAN_FRAMEWORK_DIRS_OPENTDF-CLIENT )
set(CONAN_LIBS_OPENTDF-CLIENT opentdf_static)
set(CONAN_PKG_LIBS_OPENTDF-CLIENT opentdf_static)
set(CONAN_SYSTEM_LIBS_OPENTDF-CLIENT )
set(CONAN_FRAMEWORKS_OPENTDF-CLIENT )
set(CONAN_FRAMEWORKS_FOUND_OPENTDF-CLIENT "")  # Will be filled later
set(CONAN_DEFINES_OPENTDF-CLIENT )
set(CONAN_BUILD_MODULES_PATHS_OPENTDF-CLIENT )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENTDF-CLIENT )

set(CONAN_C_FLAGS_OPENTDF-CLIENT "")
set(CONAN_CXX_FLAGS_OPENTDF-CLIENT "")
set(CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT "")
set(CONAN_EXE_LINKER_FLAGS_OPENTDF-CLIENT "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENTDF-CLIENT_LIST "")
set(CONAN_CXX_FLAGS_OPENTDF-CLIENT_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENTDF-CLIENT_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENTDF-CLIENT "${CONAN_FRAMEWORKS_OPENTDF-CLIENT}" "_OPENTDF-CLIENT" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENTDF-CLIENT ${CONAN_PKG_LIBS_OPENTDF-CLIENT} ${CONAN_SYSTEM_LIBS_OPENTDF-CLIENT} ${CONAN_FRAMEWORKS_FOUND_OPENTDF-CLIENT})


#################
###  MS-GSL
#################
set(CONAN_MS-GSL_ROOT "/Users/vheneraliuk/.conan/data/ms-gsl/2.1.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_MS-GSL "/Users/vheneraliuk/.conan/data/ms-gsl/2.1.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_MS-GSL )
set(CONAN_BIN_DIRS_MS-GSL )
set(CONAN_RES_DIRS_MS-GSL )
set(CONAN_SRC_DIRS_MS-GSL )
set(CONAN_BUILD_DIRS_MS-GSL )
set(CONAN_FRAMEWORK_DIRS_MS-GSL )
set(CONAN_LIBS_MS-GSL )
set(CONAN_PKG_LIBS_MS-GSL )
set(CONAN_SYSTEM_LIBS_MS-GSL )
set(CONAN_FRAMEWORKS_MS-GSL )
set(CONAN_FRAMEWORKS_FOUND_MS-GSL "")  # Will be filled later
set(CONAN_DEFINES_MS-GSL "-DGSL_TERMINATE_ON_CONTRACT_VIOLATION")
set(CONAN_BUILD_MODULES_PATHS_MS-GSL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_MS-GSL "GSL_TERMINATE_ON_CONTRACT_VIOLATION")

set(CONAN_C_FLAGS_MS-GSL "")
set(CONAN_CXX_FLAGS_MS-GSL "")
set(CONAN_SHARED_LINKER_FLAGS_MS-GSL "")
set(CONAN_EXE_LINKER_FLAGS_MS-GSL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_MS-GSL_LIST "")
set(CONAN_CXX_FLAGS_MS-GSL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_MS-GSL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_MS-GSL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_MS-GSL "${CONAN_FRAMEWORKS_MS-GSL}" "_MS-GSL" "")
# Append to aggregated values variable
set(CONAN_LIBS_MS-GSL ${CONAN_PKG_LIBS_MS-GSL} ${CONAN_SYSTEM_LIBS_MS-GSL} ${CONAN_FRAMEWORKS_FOUND_MS-GSL})


#################
###  NLOHMANN_JSON
#################
set(CONAN_NLOHMANN_JSON_ROOT "/Users/vheneraliuk/.conan/data/nlohmann_json/3.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_NLOHMANN_JSON "/Users/vheneraliuk/.conan/data/nlohmann_json/3.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_NLOHMANN_JSON )
set(CONAN_BIN_DIRS_NLOHMANN_JSON )
set(CONAN_RES_DIRS_NLOHMANN_JSON )
set(CONAN_SRC_DIRS_NLOHMANN_JSON )
set(CONAN_BUILD_DIRS_NLOHMANN_JSON "/Users/vheneraliuk/.conan/data/nlohmann_json/3.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_NLOHMANN_JSON )
set(CONAN_LIBS_NLOHMANN_JSON )
set(CONAN_PKG_LIBS_NLOHMANN_JSON )
set(CONAN_SYSTEM_LIBS_NLOHMANN_JSON )
set(CONAN_FRAMEWORKS_NLOHMANN_JSON )
set(CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON "")  # Will be filled later
set(CONAN_DEFINES_NLOHMANN_JSON )
set(CONAN_BUILD_MODULES_PATHS_NLOHMANN_JSON )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_NLOHMANN_JSON )

set(CONAN_C_FLAGS_NLOHMANN_JSON "")
set(CONAN_CXX_FLAGS_NLOHMANN_JSON "")
set(CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON "")
set(CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_NLOHMANN_JSON_LIST "")
set(CONAN_CXX_FLAGS_NLOHMANN_JSON_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_LIST "")
set(CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON "${CONAN_FRAMEWORKS_NLOHMANN_JSON}" "_NLOHMANN_JSON" "")
# Append to aggregated values variable
set(CONAN_LIBS_NLOHMANN_JSON ${CONAN_PKG_LIBS_NLOHMANN_JSON} ${CONAN_SYSTEM_LIBS_NLOHMANN_JSON} ${CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON})


#################
###  JWT-CPP
#################
set(CONAN_JWT-CPP_ROOT "/Users/vheneraliuk/.conan/data/jwt-cpp/0.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_JWT-CPP "/Users/vheneraliuk/.conan/data/jwt-cpp/0.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_JWT-CPP )
set(CONAN_BIN_DIRS_JWT-CPP )
set(CONAN_RES_DIRS_JWT-CPP )
set(CONAN_SRC_DIRS_JWT-CPP )
set(CONAN_BUILD_DIRS_JWT-CPP "/Users/vheneraliuk/.conan/data/jwt-cpp/0.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_JWT-CPP )
set(CONAN_LIBS_JWT-CPP )
set(CONAN_PKG_LIBS_JWT-CPP )
set(CONAN_SYSTEM_LIBS_JWT-CPP )
set(CONAN_FRAMEWORKS_JWT-CPP )
set(CONAN_FRAMEWORKS_FOUND_JWT-CPP "")  # Will be filled later
set(CONAN_DEFINES_JWT-CPP )
set(CONAN_BUILD_MODULES_PATHS_JWT-CPP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_JWT-CPP )

set(CONAN_C_FLAGS_JWT-CPP "")
set(CONAN_CXX_FLAGS_JWT-CPP "")
set(CONAN_SHARED_LINKER_FLAGS_JWT-CPP "")
set(CONAN_EXE_LINKER_FLAGS_JWT-CPP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_JWT-CPP_LIST "")
set(CONAN_CXX_FLAGS_JWT-CPP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_JWT-CPP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_JWT-CPP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_JWT-CPP "${CONAN_FRAMEWORKS_JWT-CPP}" "_JWT-CPP" "")
# Append to aggregated values variable
set(CONAN_LIBS_JWT-CPP ${CONAN_PKG_LIBS_JWT-CPP} ${CONAN_SYSTEM_LIBS_JWT-CPP} ${CONAN_FRAMEWORKS_FOUND_JWT-CPP})


#################
###  BOOST
#################
set(CONAN_BOOST_ROOT "/Users/vheneraliuk/.conan/data/boost/1.81.0/_/_/package/142703d75704b53f97fd136456e4ffb8abc6b7cb")
set(CONAN_INCLUDE_DIRS_BOOST "/Users/vheneraliuk/.conan/data/boost/1.81.0/_/_/package/142703d75704b53f97fd136456e4ffb8abc6b7cb/include")
set(CONAN_LIB_DIRS_BOOST "/Users/vheneraliuk/.conan/data/boost/1.81.0/_/_/package/142703d75704b53f97fd136456e4ffb8abc6b7cb/lib")
set(CONAN_BIN_DIRS_BOOST )
set(CONAN_RES_DIRS_BOOST )
set(CONAN_SRC_DIRS_BOOST )
set(CONAN_BUILD_DIRS_BOOST )
set(CONAN_FRAMEWORK_DIRS_BOOST )
set(CONAN_LIBS_BOOST boost_contract boost_coroutine boost_fiber_numa boost_fiber boost_context boost_graph boost_iostreams boost_json boost_locale boost_log_setup boost_log boost_math_c99 boost_math_c99f boost_math_c99l boost_math_tr1 boost_math_tr1f boost_math_tr1l boost_nowide boost_program_options boost_random boost_regex boost_stacktrace_addr2line boost_stacktrace_backtrace boost_stacktrace_basic boost_stacktrace_noop boost_timer boost_type_erasure boost_thread boost_chrono boost_container boost_date_time boost_unit_test_framework boost_prg_exec_monitor boost_test_exec_monitor boost_exception boost_url boost_wave boost_filesystem boost_atomic boost_wserialization boost_serialization)
set(CONAN_PKG_LIBS_BOOST boost_contract boost_coroutine boost_fiber_numa boost_fiber boost_context boost_graph boost_iostreams boost_json boost_locale boost_log_setup boost_log boost_math_c99 boost_math_c99f boost_math_c99l boost_math_tr1 boost_math_tr1f boost_math_tr1l boost_nowide boost_program_options boost_random boost_regex boost_stacktrace_addr2line boost_stacktrace_backtrace boost_stacktrace_basic boost_stacktrace_noop boost_timer boost_type_erasure boost_thread boost_chrono boost_container boost_date_time boost_unit_test_framework boost_prg_exec_monitor boost_test_exec_monitor boost_exception boost_url boost_wave boost_filesystem boost_atomic boost_wserialization boost_serialization)
set(CONAN_SYSTEM_LIBS_BOOST )
set(CONAN_FRAMEWORKS_BOOST )
set(CONAN_FRAMEWORKS_FOUND_BOOST "")  # Will be filled later
set(CONAN_DEFINES_BOOST "-DBOOST_STACKTRACE_ADDR2LINE_LOCATION=\"/usr/bin/addr2line\""
			"-DBOOST_STACKTRACE_USE_ADDR2LINE"
			"-DBOOST_STACKTRACE_USE_BACKTRACE"
			"-DBOOST_STACKTRACE_USE_NOOP")
set(CONAN_BUILD_MODULES_PATHS_BOOST )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BOOST "BOOST_STACKTRACE_ADDR2LINE_LOCATION=\"/usr/bin/addr2line\""
			"BOOST_STACKTRACE_USE_ADDR2LINE"
			"BOOST_STACKTRACE_USE_BACKTRACE"
			"BOOST_STACKTRACE_USE_NOOP")

set(CONAN_C_FLAGS_BOOST "")
set(CONAN_CXX_FLAGS_BOOST "")
set(CONAN_SHARED_LINKER_FLAGS_BOOST "")
set(CONAN_EXE_LINKER_FLAGS_BOOST "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BOOST_LIST "")
set(CONAN_CXX_FLAGS_BOOST_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BOOST_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BOOST_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BOOST "${CONAN_FRAMEWORKS_BOOST}" "_BOOST" "")
# Append to aggregated values variable
set(CONAN_LIBS_BOOST ${CONAN_PKG_LIBS_BOOST} ${CONAN_SYSTEM_LIBS_BOOST} ${CONAN_FRAMEWORKS_FOUND_BOOST})


#################
###  LIBXML2
#################
set(CONAN_LIBXML2_ROOT "/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e")
set(CONAN_INCLUDE_DIRS_LIBXML2 "/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/include"
			"/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/include/libxml2")
set(CONAN_LIB_DIRS_LIBXML2 "/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/lib")
set(CONAN_BIN_DIRS_LIBXML2 "/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/bin")
set(CONAN_RES_DIRS_LIBXML2 )
set(CONAN_SRC_DIRS_LIBXML2 )
set(CONAN_BUILD_DIRS_LIBXML2 "/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/")
set(CONAN_FRAMEWORK_DIRS_LIBXML2 )
set(CONAN_LIBS_LIBXML2 xml2)
set(CONAN_PKG_LIBS_LIBXML2 xml2)
set(CONAN_SYSTEM_LIBS_LIBXML2 m)
set(CONAN_FRAMEWORKS_LIBXML2 )
set(CONAN_FRAMEWORKS_FOUND_LIBXML2 "")  # Will be filled later
set(CONAN_DEFINES_LIBXML2 "-DLIBXML_STATIC")
set(CONAN_BUILD_MODULES_PATHS_LIBXML2 )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBXML2 "LIBXML_STATIC")

set(CONAN_C_FLAGS_LIBXML2 "")
set(CONAN_CXX_FLAGS_LIBXML2 "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXML2 "")
set(CONAN_EXE_LINKER_FLAGS_LIBXML2 "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBXML2_LIST "")
set(CONAN_CXX_FLAGS_LIBXML2_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXML2_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBXML2_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBXML2 "${CONAN_FRAMEWORKS_LIBXML2}" "_LIBXML2" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBXML2 ${CONAN_PKG_LIBS_LIBXML2} ${CONAN_SYSTEM_LIBS_LIBXML2} ${CONAN_FRAMEWORKS_FOUND_LIBXML2})


#################
###  OPENSSL
#################
set(CONAN_OPENSSL_ROOT "/Users/vheneraliuk/.conan/data/openssl/1.1.1q/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13")
set(CONAN_INCLUDE_DIRS_OPENSSL "/Users/vheneraliuk/.conan/data/openssl/1.1.1q/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/include")
set(CONAN_LIB_DIRS_OPENSSL "/Users/vheneraliuk/.conan/data/openssl/1.1.1q/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/lib")
set(CONAN_BIN_DIRS_OPENSSL "/Users/vheneraliuk/.conan/data/openssl/1.1.1q/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/bin")
set(CONAN_RES_DIRS_OPENSSL )
set(CONAN_SRC_DIRS_OPENSSL )
set(CONAN_BUILD_DIRS_OPENSSL )
set(CONAN_FRAMEWORK_DIRS_OPENSSL )
set(CONAN_LIBS_OPENSSL ssl crypto)
set(CONAN_PKG_LIBS_OPENSSL ssl crypto)
set(CONAN_SYSTEM_LIBS_OPENSSL )
set(CONAN_FRAMEWORKS_OPENSSL )
set(CONAN_FRAMEWORKS_FOUND_OPENSSL "")  # Will be filled later
set(CONAN_DEFINES_OPENSSL )
set(CONAN_BUILD_MODULES_PATHS_OPENSSL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENSSL )

set(CONAN_C_FLAGS_OPENSSL "")
set(CONAN_CXX_FLAGS_OPENSSL "")
set(CONAN_SHARED_LINKER_FLAGS_OPENSSL "")
set(CONAN_EXE_LINKER_FLAGS_OPENSSL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENSSL_LIST "")
set(CONAN_CXX_FLAGS_OPENSSL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENSSL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENSSL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENSSL "${CONAN_FRAMEWORKS_OPENSSL}" "_OPENSSL" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENSSL ${CONAN_PKG_LIBS_OPENSSL} ${CONAN_SYSTEM_LIBS_OPENSSL} ${CONAN_FRAMEWORKS_FOUND_OPENSSL})


#################
###  PICOJSON
#################
set(CONAN_PICOJSON_ROOT "/Users/vheneraliuk/.conan/data/picojson/1.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_PICOJSON "/Users/vheneraliuk/.conan/data/picojson/1.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_PICOJSON )
set(CONAN_BIN_DIRS_PICOJSON )
set(CONAN_RES_DIRS_PICOJSON )
set(CONAN_SRC_DIRS_PICOJSON )
set(CONAN_BUILD_DIRS_PICOJSON "/Users/vheneraliuk/.conan/data/picojson/1.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_PICOJSON )
set(CONAN_LIBS_PICOJSON )
set(CONAN_PKG_LIBS_PICOJSON )
set(CONAN_SYSTEM_LIBS_PICOJSON )
set(CONAN_FRAMEWORKS_PICOJSON )
set(CONAN_FRAMEWORKS_FOUND_PICOJSON "")  # Will be filled later
set(CONAN_DEFINES_PICOJSON )
set(CONAN_BUILD_MODULES_PATHS_PICOJSON )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_PICOJSON )

set(CONAN_C_FLAGS_PICOJSON "")
set(CONAN_CXX_FLAGS_PICOJSON "")
set(CONAN_SHARED_LINKER_FLAGS_PICOJSON "")
set(CONAN_EXE_LINKER_FLAGS_PICOJSON "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_PICOJSON_LIST "")
set(CONAN_CXX_FLAGS_PICOJSON_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_PICOJSON_LIST "")
set(CONAN_EXE_LINKER_FLAGS_PICOJSON_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_PICOJSON "${CONAN_FRAMEWORKS_PICOJSON}" "_PICOJSON" "")
# Append to aggregated values variable
set(CONAN_LIBS_PICOJSON ${CONAN_PKG_LIBS_PICOJSON} ${CONAN_SYSTEM_LIBS_PICOJSON} ${CONAN_FRAMEWORKS_FOUND_PICOJSON})


#################
###  ZLIB
#################
set(CONAN_ZLIB_ROOT "/Users/vheneraliuk/.conan/data/zlib/1.2.13/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13")
set(CONAN_INCLUDE_DIRS_ZLIB "/Users/vheneraliuk/.conan/data/zlib/1.2.13/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/include")
set(CONAN_LIB_DIRS_ZLIB "/Users/vheneraliuk/.conan/data/zlib/1.2.13/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/lib")
set(CONAN_BIN_DIRS_ZLIB )
set(CONAN_RES_DIRS_ZLIB )
set(CONAN_SRC_DIRS_ZLIB )
set(CONAN_BUILD_DIRS_ZLIB "/Users/vheneraliuk/.conan/data/zlib/1.2.13/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/")
set(CONAN_FRAMEWORK_DIRS_ZLIB )
set(CONAN_LIBS_ZLIB z)
set(CONAN_PKG_LIBS_ZLIB z)
set(CONAN_SYSTEM_LIBS_ZLIB )
set(CONAN_FRAMEWORKS_ZLIB )
set(CONAN_FRAMEWORKS_FOUND_ZLIB "")  # Will be filled later
set(CONAN_DEFINES_ZLIB )
set(CONAN_BUILD_MODULES_PATHS_ZLIB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ZLIB )

set(CONAN_C_FLAGS_ZLIB "")
set(CONAN_CXX_FLAGS_ZLIB "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ZLIB_LIST "")
set(CONAN_CXX_FLAGS_ZLIB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ZLIB "${CONAN_FRAMEWORKS_ZLIB}" "_ZLIB" "")
# Append to aggregated values variable
set(CONAN_LIBS_ZLIB ${CONAN_PKG_LIBS_ZLIB} ${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB})


#################
###  BZIP2
#################
set(CONAN_BZIP2_ROOT "/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb")
set(CONAN_INCLUDE_DIRS_BZIP2 "/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb/include")
set(CONAN_LIB_DIRS_BZIP2 "/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb/lib")
set(CONAN_BIN_DIRS_BZIP2 "/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb/bin")
set(CONAN_RES_DIRS_BZIP2 )
set(CONAN_SRC_DIRS_BZIP2 )
set(CONAN_BUILD_DIRS_BZIP2 "/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb/")
set(CONAN_FRAMEWORK_DIRS_BZIP2 )
set(CONAN_LIBS_BZIP2 bz2)
set(CONAN_PKG_LIBS_BZIP2 bz2)
set(CONAN_SYSTEM_LIBS_BZIP2 )
set(CONAN_FRAMEWORKS_BZIP2 )
set(CONAN_FRAMEWORKS_FOUND_BZIP2 "")  # Will be filled later
set(CONAN_DEFINES_BZIP2 )
set(CONAN_BUILD_MODULES_PATHS_BZIP2 )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BZIP2 )

set(CONAN_C_FLAGS_BZIP2 "")
set(CONAN_CXX_FLAGS_BZIP2 "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2 "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2 "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BZIP2_LIST "")
set(CONAN_CXX_FLAGS_BZIP2_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BZIP2 "${CONAN_FRAMEWORKS_BZIP2}" "_BZIP2" "")
# Append to aggregated values variable
set(CONAN_LIBS_BZIP2 ${CONAN_PKG_LIBS_BZIP2} ${CONAN_SYSTEM_LIBS_BZIP2} ${CONAN_FRAMEWORKS_FOUND_BZIP2})


#################
###  LIBBACKTRACE
#################
set(CONAN_LIBBACKTRACE_ROOT "/Users/vheneraliuk/.conan/data/libbacktrace/cci.20210118/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13")
set(CONAN_INCLUDE_DIRS_LIBBACKTRACE "/Users/vheneraliuk/.conan/data/libbacktrace/cci.20210118/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/include")
set(CONAN_LIB_DIRS_LIBBACKTRACE "/Users/vheneraliuk/.conan/data/libbacktrace/cci.20210118/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/lib")
set(CONAN_BIN_DIRS_LIBBACKTRACE )
set(CONAN_RES_DIRS_LIBBACKTRACE )
set(CONAN_SRC_DIRS_LIBBACKTRACE )
set(CONAN_BUILD_DIRS_LIBBACKTRACE "/Users/vheneraliuk/.conan/data/libbacktrace/cci.20210118/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/")
set(CONAN_FRAMEWORK_DIRS_LIBBACKTRACE )
set(CONAN_LIBS_LIBBACKTRACE backtrace)
set(CONAN_PKG_LIBS_LIBBACKTRACE backtrace)
set(CONAN_SYSTEM_LIBS_LIBBACKTRACE )
set(CONAN_FRAMEWORKS_LIBBACKTRACE )
set(CONAN_FRAMEWORKS_FOUND_LIBBACKTRACE "")  # Will be filled later
set(CONAN_DEFINES_LIBBACKTRACE )
set(CONAN_BUILD_MODULES_PATHS_LIBBACKTRACE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBBACKTRACE )

set(CONAN_C_FLAGS_LIBBACKTRACE "")
set(CONAN_CXX_FLAGS_LIBBACKTRACE "")
set(CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE "")
set(CONAN_EXE_LINKER_FLAGS_LIBBACKTRACE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBBACKTRACE_LIST "")
set(CONAN_CXX_FLAGS_LIBBACKTRACE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBBACKTRACE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBBACKTRACE "${CONAN_FRAMEWORKS_LIBBACKTRACE}" "_LIBBACKTRACE" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBBACKTRACE ${CONAN_PKG_LIBS_LIBBACKTRACE} ${CONAN_SYSTEM_LIBS_LIBBACKTRACE} ${CONAN_FRAMEWORKS_FOUND_LIBBACKTRACE})


#################
###  LIBICONV
#################
set(CONAN_LIBICONV_ROOT "/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13")
set(CONAN_INCLUDE_DIRS_LIBICONV "/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/include")
set(CONAN_LIB_DIRS_LIBICONV "/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/lib")
set(CONAN_BIN_DIRS_LIBICONV "/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/bin")
set(CONAN_RES_DIRS_LIBICONV )
set(CONAN_SRC_DIRS_LIBICONV )
set(CONAN_BUILD_DIRS_LIBICONV "/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/")
set(CONAN_FRAMEWORK_DIRS_LIBICONV )
set(CONAN_LIBS_LIBICONV iconv charset)
set(CONAN_PKG_LIBS_LIBICONV iconv charset)
set(CONAN_SYSTEM_LIBS_LIBICONV )
set(CONAN_FRAMEWORKS_LIBICONV )
set(CONAN_FRAMEWORKS_FOUND_LIBICONV "")  # Will be filled later
set(CONAN_DEFINES_LIBICONV )
set(CONAN_BUILD_MODULES_PATHS_LIBICONV )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBICONV )

set(CONAN_C_FLAGS_LIBICONV "")
set(CONAN_CXX_FLAGS_LIBICONV "")
set(CONAN_SHARED_LINKER_FLAGS_LIBICONV "")
set(CONAN_EXE_LINKER_FLAGS_LIBICONV "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBICONV_LIST "")
set(CONAN_CXX_FLAGS_LIBICONV_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBICONV_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBICONV_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBICONV "${CONAN_FRAMEWORKS_LIBICONV}" "_LIBICONV" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBICONV ${CONAN_PKG_LIBS_LIBICONV} ${CONAN_SYSTEM_LIBS_LIBICONV} ${CONAN_FRAMEWORKS_FOUND_LIBICONV})


### Definition of global aggregated variables ###

set(CONAN_PACKAGE_NAME None)
set(CONAN_PACKAGE_VERSION None)

set(CONAN_SETTINGS_ARCH "armv8")
set(CONAN_SETTINGS_BUILD_TYPE "Release")
set(CONAN_SETTINGS_COMPILER "clang")
set(CONAN_SETTINGS_COMPILER_LIBCXX "libc++")
set(CONAN_SETTINGS_COMPILER_VERSION "14")
set(CONAN_SETTINGS_OS "Android")
set(CONAN_SETTINGS_OS_API_LEVEL "21")

set(CONAN_DEPENDENCIES pybind11 opentdf-client ms-gsl nlohmann_json jwt-cpp boost libxml2 openssl picojson zlib bzip2 libbacktrace libiconv)
# Storing original command line args (CMake helper) flags
set(CONAN_CMD_CXX_FLAGS ${CONAN_CXX_FLAGS})

set(CONAN_CMD_SHARED_LINKER_FLAGS ${CONAN_SHARED_LINKER_FLAGS})
set(CONAN_CMD_C_FLAGS ${CONAN_C_FLAGS})
# Defining accumulated conan variables for all deps

set(CONAN_INCLUDE_DIRS "/Users/vheneraliuk/.conan/data/pybind11/2.10.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/include"
			"/Users/vheneraliuk/.conan/data/ms-gsl/2.1.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/Users/vheneraliuk/.conan/data/nlohmann_json/3.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/Users/vheneraliuk/.conan/data/jwt-cpp/0.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/Users/vheneraliuk/.conan/data/boost/1.81.0/_/_/package/142703d75704b53f97fd136456e4ffb8abc6b7cb/include"
			"/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/include"
			"/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/include/libxml2"
			"/Users/vheneraliuk/.conan/data/openssl/1.1.1q/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/include"
			"/Users/vheneraliuk/.conan/data/picojson/1.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/Users/vheneraliuk/.conan/data/zlib/1.2.13/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/include"
			"/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb/include"
			"/Users/vheneraliuk/.conan/data/libbacktrace/cci.20210118/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/include"
			"/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/include" ${CONAN_INCLUDE_DIRS})
set(CONAN_LIB_DIRS "/Users/vheneraliuk/.conan/data/pybind11/2.10.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib"
			"/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/lib"
			"/Users/vheneraliuk/.conan/data/boost/1.81.0/_/_/package/142703d75704b53f97fd136456e4ffb8abc6b7cb/lib"
			"/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/lib"
			"/Users/vheneraliuk/.conan/data/openssl/1.1.1q/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/lib"
			"/Users/vheneraliuk/.conan/data/zlib/1.2.13/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/lib"
			"/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb/lib"
			"/Users/vheneraliuk/.conan/data/libbacktrace/cci.20210118/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/lib"
			"/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/lib" ${CONAN_LIB_DIRS})
set(CONAN_BIN_DIRS "/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/bin"
			"/Users/vheneraliuk/.conan/data/openssl/1.1.1q/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/bin"
			"/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb/bin"
			"/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/bin" ${CONAN_BIN_DIRS})
set(CONAN_RES_DIRS  ${CONAN_RES_DIRS})
set(CONAN_FRAMEWORK_DIRS  ${CONAN_FRAMEWORK_DIRS})
set(CONAN_LIBS opentdf_static boost_contract boost_coroutine boost_fiber_numa boost_fiber boost_context boost_graph boost_iostreams boost_json boost_locale boost_log_setup boost_log boost_math_c99 boost_math_c99f boost_math_c99l boost_math_tr1 boost_math_tr1f boost_math_tr1l boost_nowide boost_program_options boost_random boost_regex boost_stacktrace_addr2line boost_stacktrace_backtrace boost_stacktrace_basic boost_stacktrace_noop boost_timer boost_type_erasure boost_thread boost_chrono boost_container boost_date_time boost_unit_test_framework boost_prg_exec_monitor boost_test_exec_monitor boost_exception boost_url boost_wave boost_filesystem boost_atomic boost_wserialization boost_serialization xml2 ssl crypto z bz2 backtrace iconv charset ${CONAN_LIBS})
set(CONAN_PKG_LIBS opentdf_static boost_contract boost_coroutine boost_fiber_numa boost_fiber boost_context boost_graph boost_iostreams boost_json boost_locale boost_log_setup boost_log boost_math_c99 boost_math_c99f boost_math_c99l boost_math_tr1 boost_math_tr1f boost_math_tr1l boost_nowide boost_program_options boost_random boost_regex boost_stacktrace_addr2line boost_stacktrace_backtrace boost_stacktrace_basic boost_stacktrace_noop boost_timer boost_type_erasure boost_thread boost_chrono boost_container boost_date_time boost_unit_test_framework boost_prg_exec_monitor boost_test_exec_monitor boost_exception boost_url boost_wave boost_filesystem boost_atomic boost_wserialization boost_serialization xml2 ssl crypto z bz2 backtrace iconv charset ${CONAN_PKG_LIBS})
set(CONAN_SYSTEM_LIBS m ${CONAN_SYSTEM_LIBS})
set(CONAN_FRAMEWORKS  ${CONAN_FRAMEWORKS})
set(CONAN_FRAMEWORKS_FOUND "")  # Will be filled later
set(CONAN_DEFINES "-DLIBXML_STATIC"
			"-DBOOST_STACKTRACE_ADDR2LINE_LOCATION=\"/usr/bin/addr2line\""
			"-DBOOST_STACKTRACE_USE_ADDR2LINE"
			"-DBOOST_STACKTRACE_USE_BACKTRACE"
			"-DBOOST_STACKTRACE_USE_NOOP"
			"-DGSL_TERMINATE_ON_CONTRACT_VIOLATION" ${CONAN_DEFINES})
set(CONAN_BUILD_MODULES_PATHS  ${CONAN_BUILD_MODULES_PATHS})
set(CONAN_CMAKE_MODULE_PATH "/Users/vheneraliuk/.conan/data/pybind11/2.10.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/cmake/pybind11"
			"/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/"
			"/Users/vheneraliuk/.conan/data/nlohmann_json/3.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/Users/vheneraliuk/.conan/data/jwt-cpp/0.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/Users/vheneraliuk/.conan/data/libxml2/2.10.3/_/_/package/ffb1ae0b41c6b03e9a717ec0b29f513fe17f6a5e/"
			"/Users/vheneraliuk/.conan/data/picojson/1.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/Users/vheneraliuk/.conan/data/zlib/1.2.13/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/"
			"/Users/vheneraliuk/.conan/data/bzip2/1.0.8/_/_/package/2070bdc52264ee5d766c364d856228708d6cadbb/"
			"/Users/vheneraliuk/.conan/data/libbacktrace/cci.20210118/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/"
			"/Users/vheneraliuk/.conan/data/libiconv/1.17/_/_/package/8cbfc05d3e76d0a8b10531035a234407976a6e13/" ${CONAN_CMAKE_MODULE_PATH})

set(CONAN_CXX_FLAGS " ${CONAN_CXX_FLAGS}")
set(CONAN_SHARED_LINKER_FLAGS " ${CONAN_SHARED_LINKER_FLAGS}")
set(CONAN_EXE_LINKER_FLAGS " ${CONAN_EXE_LINKER_FLAGS}")
set(CONAN_C_FLAGS " ${CONAN_C_FLAGS}")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND "${CONAN_FRAMEWORKS}" "" "")
# Append to aggregated values variable: Use CONAN_LIBS instead of CONAN_PKG_LIBS to include user appended vars
set(CONAN_LIBS ${CONAN_LIBS} ${CONAN_SYSTEM_LIBS} ${CONAN_FRAMEWORKS_FOUND})


###  Definition of macros and functions ###

macro(conan_define_targets)
    if(${CMAKE_VERSION} VERSION_LESS "3.1.2")
        message(FATAL_ERROR "TARGETS not supported by your CMake version!")
    endif()  # CMAKE > 3.x
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CONAN_CMD_CXX_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CONAN_CMD_C_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${CONAN_CMD_SHARED_LINKER_FLAGS}")


    set(_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES "${CONAN_SYSTEM_LIBS_PYBIND11} ${CONAN_FRAMEWORKS_FOUND_PYBIND11} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PYBIND11}" "${CONAN_LIB_DIRS_PYBIND11}"
                                  CONAN_PACKAGE_TARGETS_PYBIND11 "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES}"
                                  "" pybind11)
    set(_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_PYBIND11_DEBUG} ${CONAN_FRAMEWORKS_FOUND_PYBIND11_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PYBIND11_DEBUG}" "${CONAN_LIB_DIRS_PYBIND11_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_PYBIND11_DEBUG "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_DEBUG}"
                                  "debug" pybind11)
    set(_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_PYBIND11_RELEASE} ${CONAN_FRAMEWORKS_FOUND_PYBIND11_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PYBIND11_RELEASE}" "${CONAN_LIB_DIRS_PYBIND11_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_PYBIND11_RELEASE "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELEASE}"
                                  "release" pybind11)
    set(_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_PYBIND11_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_PYBIND11_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PYBIND11_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_PYBIND11_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_PYBIND11_RELWITHDEBINFO "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" pybind11)
    set(_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_PYBIND11_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_PYBIND11_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PYBIND11_MINSIZEREL}" "${CONAN_LIB_DIRS_PYBIND11_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_PYBIND11_MINSIZEREL "${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" pybind11)

    add_library(CONAN_PKG::pybind11 INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::pybind11 PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_PYBIND11} ${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PYBIND11_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_PYBIND11_RELEASE} ${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PYBIND11_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_PYBIND11_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PYBIND11_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_PYBIND11_MINSIZEREL} ${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PYBIND11_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_PYBIND11_DEBUG} ${_CONAN_PKG_LIBS_PYBIND11_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PYBIND11_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PYBIND11_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::pybind11 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_PYBIND11}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_PYBIND11_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_PYBIND11_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_PYBIND11_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_PYBIND11_DEBUG}>)
    set_property(TARGET CONAN_PKG::pybind11 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_PYBIND11}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_PYBIND11_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_PYBIND11_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_PYBIND11_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_PYBIND11_DEBUG}>)
    set_property(TARGET CONAN_PKG::pybind11 PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_PYBIND11_LIST} ${CONAN_CXX_FLAGS_PYBIND11_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_PYBIND11_RELEASE_LIST} ${CONAN_CXX_FLAGS_PYBIND11_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_PYBIND11_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_PYBIND11_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_PYBIND11_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_PYBIND11_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_PYBIND11_DEBUG_LIST}  ${CONAN_CXX_FLAGS_PYBIND11_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENTDF-CLIENT} ${CONAN_FRAMEWORKS_FOUND_OPENTDF-CLIENT} CONAN_PKG::openssl CONAN_PKG::ms-gsl CONAN_PKG::nlohmann_json CONAN_PKG::jwt-cpp CONAN_PKG::boost CONAN_PKG::libxml2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENTDF-CLIENT}" "${CONAN_LIB_DIRS_OPENTDF-CLIENT}"
                                  CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES}"
                                  "" opentdf-client)
    set(_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENTDF-CLIENT_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENTDF-CLIENT_DEBUG} CONAN_PKG::openssl CONAN_PKG::ms-gsl CONAN_PKG::nlohmann_json CONAN_PKG::jwt-cpp CONAN_PKG::boost CONAN_PKG::libxml2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENTDF-CLIENT_DEBUG}" "${CONAN_LIB_DIRS_OPENTDF-CLIENT_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT_DEBUG "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_DEBUG}"
                                  "debug" opentdf-client)
    set(_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENTDF-CLIENT_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENTDF-CLIENT_RELEASE} CONAN_PKG::openssl CONAN_PKG::ms-gsl CONAN_PKG::nlohmann_json CONAN_PKG::jwt-cpp CONAN_PKG::boost CONAN_PKG::libxml2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENTDF-CLIENT_RELEASE}" "${CONAN_LIB_DIRS_OPENTDF-CLIENT_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT_RELEASE "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELEASE}"
                                  "release" opentdf-client)
    set(_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENTDF-CLIENT_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENTDF-CLIENT_RELWITHDEBINFO} CONAN_PKG::openssl CONAN_PKG::ms-gsl CONAN_PKG::nlohmann_json CONAN_PKG::jwt-cpp CONAN_PKG::boost CONAN_PKG::libxml2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENTDF-CLIENT_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENTDF-CLIENT_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" opentdf-client)
    set(_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENTDF-CLIENT_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENTDF-CLIENT_MINSIZEREL} CONAN_PKG::openssl CONAN_PKG::ms-gsl CONAN_PKG::nlohmann_json CONAN_PKG::jwt-cpp CONAN_PKG::boost CONAN_PKG::libxml2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENTDF-CLIENT_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENTDF-CLIENT_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT_MINSIZEREL "${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" opentdf-client)

    add_library(CONAN_PKG::opentdf-client INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::opentdf-client PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT} ${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENTDF-CLIENT_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT_RELEASE} ${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENTDF-CLIENT_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENTDF-CLIENT_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENTDF-CLIENT_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENTDF-CLIENT_DEBUG} ${_CONAN_PKG_LIBS_OPENTDF-CLIENT_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENTDF-CLIENT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENTDF-CLIENT_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::opentdf-client PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENTDF-CLIENT}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENTDF-CLIENT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENTDF-CLIENT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENTDF-CLIENT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENTDF-CLIENT_DEBUG}>)
    set_property(TARGET CONAN_PKG::opentdf-client PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENTDF-CLIENT}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENTDF-CLIENT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENTDF-CLIENT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENTDF-CLIENT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENTDF-CLIENT_DEBUG}>)
    set_property(TARGET CONAN_PKG::opentdf-client PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENTDF-CLIENT_LIST} ${CONAN_CXX_FLAGS_OPENTDF-CLIENT_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENTDF-CLIENT_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENTDF-CLIENT_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENTDF-CLIENT_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENTDF-CLIENT_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENTDF-CLIENT_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENTDF-CLIENT_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENTDF-CLIENT_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENTDF-CLIENT_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES "${CONAN_SYSTEM_LIBS_MS-GSL} ${CONAN_FRAMEWORKS_FOUND_MS-GSL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MS-GSL}" "${CONAN_LIB_DIRS_MS-GSL}"
                                  CONAN_PACKAGE_TARGETS_MS-GSL "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES}"
                                  "" ms-gsl)
    set(_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_MS-GSL_DEBUG} ${CONAN_FRAMEWORKS_FOUND_MS-GSL_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MS-GSL_DEBUG}" "${CONAN_LIB_DIRS_MS-GSL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_MS-GSL_DEBUG "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_DEBUG}"
                                  "debug" ms-gsl)
    set(_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_MS-GSL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_MS-GSL_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MS-GSL_RELEASE}" "${CONAN_LIB_DIRS_MS-GSL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_MS-GSL_RELEASE "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELEASE}"
                                  "release" ms-gsl)
    set(_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_MS-GSL_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_MS-GSL_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MS-GSL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_MS-GSL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_MS-GSL_RELWITHDEBINFO "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" ms-gsl)
    set(_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_MS-GSL_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_MS-GSL_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MS-GSL_MINSIZEREL}" "${CONAN_LIB_DIRS_MS-GSL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_MS-GSL_MINSIZEREL "${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" ms-gsl)

    add_library(CONAN_PKG::ms-gsl INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::ms-gsl PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_MS-GSL} ${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MS-GSL_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_MS-GSL_RELEASE} ${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MS-GSL_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_MS-GSL_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MS-GSL_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_MS-GSL_MINSIZEREL} ${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MS-GSL_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_MS-GSL_DEBUG} ${_CONAN_PKG_LIBS_MS-GSL_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MS-GSL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MS-GSL_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::ms-gsl PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_MS-GSL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_MS-GSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_MS-GSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MS-GSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_MS-GSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::ms-gsl PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_MS-GSL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_MS-GSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_MS-GSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_MS-GSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_MS-GSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::ms-gsl PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_MS-GSL_LIST} ${CONAN_CXX_FLAGS_MS-GSL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_MS-GSL_RELEASE_LIST} ${CONAN_CXX_FLAGS_MS-GSL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_MS-GSL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_MS-GSL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_MS-GSL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_MS-GSL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_MS-GSL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_MS-GSL_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES "${CONAN_SYSTEM_LIBS_NLOHMANN_JSON} ${CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_NLOHMANN_JSON}" "${CONAN_LIB_DIRS_NLOHMANN_JSON}"
                                  CONAN_PACKAGE_TARGETS_NLOHMANN_JSON "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES}"
                                  "" nlohmann_json)
    set(_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_NLOHMANN_JSON_DEBUG} ${CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_NLOHMANN_JSON_DEBUG}" "${CONAN_LIB_DIRS_NLOHMANN_JSON_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_NLOHMANN_JSON_DEBUG "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_DEBUG}"
                                  "debug" nlohmann_json)
    set(_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_NLOHMANN_JSON_RELEASE} ${CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_NLOHMANN_JSON_RELEASE}" "${CONAN_LIB_DIRS_NLOHMANN_JSON_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_NLOHMANN_JSON_RELEASE "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELEASE}"
                                  "release" nlohmann_json)
    set(_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_NLOHMANN_JSON_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_NLOHMANN_JSON_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_NLOHMANN_JSON_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_NLOHMANN_JSON_RELWITHDEBINFO "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" nlohmann_json)
    set(_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_NLOHMANN_JSON_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_NLOHMANN_JSON_MINSIZEREL}" "${CONAN_LIB_DIRS_NLOHMANN_JSON_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_NLOHMANN_JSON_MINSIZEREL "${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" nlohmann_json)

    add_library(CONAN_PKG::nlohmann_json INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::nlohmann_json PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_NLOHMANN_JSON} ${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_NLOHMANN_JSON_RELEASE} ${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_NLOHMANN_JSON_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_NLOHMANN_JSON_MINSIZEREL} ${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_NLOHMANN_JSON_DEBUG} ${_CONAN_PKG_LIBS_NLOHMANN_JSON_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::nlohmann_json PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_NLOHMANN_JSON}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_NLOHMANN_JSON_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_NLOHMANN_JSON_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_NLOHMANN_JSON_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_NLOHMANN_JSON_DEBUG}>)
    set_property(TARGET CONAN_PKG::nlohmann_json PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_NLOHMANN_JSON}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_NLOHMANN_JSON_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_NLOHMANN_JSON_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_NLOHMANN_JSON_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_NLOHMANN_JSON_DEBUG}>)
    set_property(TARGET CONAN_PKG::nlohmann_json PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_NLOHMANN_JSON_LIST} ${CONAN_CXX_FLAGS_NLOHMANN_JSON_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_NLOHMANN_JSON_RELEASE_LIST} ${CONAN_CXX_FLAGS_NLOHMANN_JSON_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_NLOHMANN_JSON_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_NLOHMANN_JSON_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_NLOHMANN_JSON_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_NLOHMANN_JSON_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_NLOHMANN_JSON_DEBUG_LIST}  ${CONAN_CXX_FLAGS_NLOHMANN_JSON_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_JWT-CPP} ${CONAN_FRAMEWORKS_FOUND_JWT-CPP} CONAN_PKG::openssl CONAN_PKG::picojson")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JWT-CPP}" "${CONAN_LIB_DIRS_JWT-CPP}"
                                  CONAN_PACKAGE_TARGETS_JWT-CPP "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES}"
                                  "" jwt-cpp)
    set(_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_JWT-CPP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_JWT-CPP_DEBUG} CONAN_PKG::openssl CONAN_PKG::picojson")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JWT-CPP_DEBUG}" "${CONAN_LIB_DIRS_JWT-CPP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_JWT-CPP_DEBUG "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_DEBUG}"
                                  "debug" jwt-cpp)
    set(_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_JWT-CPP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_JWT-CPP_RELEASE} CONAN_PKG::openssl CONAN_PKG::picojson")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JWT-CPP_RELEASE}" "${CONAN_LIB_DIRS_JWT-CPP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_JWT-CPP_RELEASE "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELEASE}"
                                  "release" jwt-cpp)
    set(_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_JWT-CPP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_JWT-CPP_RELWITHDEBINFO} CONAN_PKG::openssl CONAN_PKG::picojson")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JWT-CPP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_JWT-CPP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_JWT-CPP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" jwt-cpp)
    set(_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_JWT-CPP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_JWT-CPP_MINSIZEREL} CONAN_PKG::openssl CONAN_PKG::picojson")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JWT-CPP_MINSIZEREL}" "${CONAN_LIB_DIRS_JWT-CPP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_JWT-CPP_MINSIZEREL "${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" jwt-cpp)

    add_library(CONAN_PKG::jwt-cpp INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::jwt-cpp PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_JWT-CPP} ${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JWT-CPP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_JWT-CPP_RELEASE} ${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JWT-CPP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_JWT-CPP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JWT-CPP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_JWT-CPP_MINSIZEREL} ${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JWT-CPP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_JWT-CPP_DEBUG} ${_CONAN_PKG_LIBS_JWT-CPP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JWT-CPP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JWT-CPP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::jwt-cpp PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_JWT-CPP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_JWT-CPP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_JWT-CPP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_JWT-CPP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_JWT-CPP_DEBUG}>)
    set_property(TARGET CONAN_PKG::jwt-cpp PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_JWT-CPP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_JWT-CPP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_JWT-CPP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_JWT-CPP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_JWT-CPP_DEBUG}>)
    set_property(TARGET CONAN_PKG::jwt-cpp PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_JWT-CPP_LIST} ${CONAN_CXX_FLAGS_JWT-CPP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_JWT-CPP_RELEASE_LIST} ${CONAN_CXX_FLAGS_JWT-CPP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_JWT-CPP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_JWT-CPP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_JWT-CPP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_JWT-CPP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_JWT-CPP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_JWT-CPP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES "${CONAN_SYSTEM_LIBS_BOOST} ${CONAN_FRAMEWORKS_FOUND_BOOST} CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::libbacktrace CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST}" "${CONAN_LIB_DIRS_BOOST}"
                                  CONAN_PACKAGE_TARGETS_BOOST "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES}"
                                  "" boost)
    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_BOOST_DEBUG} ${CONAN_FRAMEWORKS_FOUND_BOOST_DEBUG} CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::libbacktrace CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST_DEBUG}" "${CONAN_LIB_DIRS_BOOST_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BOOST_DEBUG "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG}"
                                  "debug" boost)
    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_BOOST_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BOOST_RELEASE} CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::libbacktrace CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST_RELEASE}" "${CONAN_LIB_DIRS_BOOST_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BOOST_RELEASE "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE}"
                                  "release" boost)
    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BOOST_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_BOOST_RELWITHDEBINFO} CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::libbacktrace CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BOOST_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BOOST_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" boost)
    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_BOOST_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_BOOST_MINSIZEREL} CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::libbacktrace CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST_MINSIZEREL}" "${CONAN_LIB_DIRS_BOOST_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BOOST_MINSIZEREL "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" boost)

    add_library(CONAN_PKG::boost INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::boost PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BOOST} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BOOST_RELEASE} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BOOST_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BOOST_MINSIZEREL} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BOOST_DEBUG} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::boost PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BOOST}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BOOST_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BOOST_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BOOST_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BOOST_DEBUG}>)
    set_property(TARGET CONAN_PKG::boost PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BOOST}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BOOST_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BOOST_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BOOST_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BOOST_DEBUG}>)
    set_property(TARGET CONAN_PKG::boost PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BOOST_LIST} ${CONAN_CXX_FLAGS_BOOST_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BOOST_RELEASE_LIST} ${CONAN_CXX_FLAGS_BOOST_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BOOST_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BOOST_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BOOST_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BOOST_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BOOST_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BOOST_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBXML2} ${CONAN_FRAMEWORKS_FOUND_LIBXML2} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2}" "${CONAN_LIB_DIRS_LIBXML2}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2 "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES}"
                                  "" libxml2)
    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBXML2_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBXML2_DEBUG} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2_DEBUG}" "${CONAN_LIB_DIRS_LIBXML2_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2_DEBUG "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG}"
                                  "debug" libxml2)
    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBXML2_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBXML2_RELEASE} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2_RELEASE}" "${CONAN_LIB_DIRS_LIBXML2_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2_RELEASE "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE}"
                                  "release" libxml2)
    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBXML2_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBXML2_RELWITHDEBINFO} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBXML2_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libxml2)
    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBXML2_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBXML2_MINSIZEREL} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBXML2_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libxml2)

    add_library(CONAN_PKG::libxml2 INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libxml2 PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBXML2} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBXML2_RELEASE} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBXML2_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBXML2_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBXML2_DEBUG} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libxml2 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBXML2}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBXML2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBXML2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBXML2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBXML2_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxml2 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBXML2}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBXML2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBXML2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBXML2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBXML2_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxml2 PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBXML2_LIST} ${CONAN_CXX_FLAGS_LIBXML2_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBXML2_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBXML2_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBXML2_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBXML2_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBXML2_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBXML2_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBXML2_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBXML2_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENSSL} ${CONAN_FRAMEWORKS_FOUND_OPENSSL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENSSL}" "${CONAN_LIB_DIRS_OPENSSL}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES}"
                                  "" openssl)
    set(_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENSSL_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENSSL_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENSSL_DEBUG}" "${CONAN_LIB_DIRS_OPENSSL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL_DEBUG "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_DEBUG}"
                                  "debug" openssl)
    set(_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENSSL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENSSL_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENSSL_RELEASE}" "${CONAN_LIB_DIRS_OPENSSL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL_RELEASE "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELEASE}"
                                  "release" openssl)
    set(_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENSSL_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENSSL_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENSSL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENSSL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" openssl)
    set(_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENSSL_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENSSL_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENSSL_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENSSL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL_MINSIZEREL "${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" openssl)

    add_library(CONAN_PKG::openssl INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::openssl PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENSSL} ${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENSSL_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENSSL_RELEASE} ${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENSSL_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENSSL_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENSSL_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENSSL_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENSSL_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENSSL_DEBUG} ${_CONAN_PKG_LIBS_OPENSSL_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENSSL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENSSL_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::openssl PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENSSL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENSSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENSSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENSSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENSSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::openssl PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENSSL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENSSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENSSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENSSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENSSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::openssl PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENSSL_LIST} ${CONAN_CXX_FLAGS_OPENSSL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENSSL_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENSSL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENSSL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENSSL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENSSL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENSSL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENSSL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENSSL_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES "${CONAN_SYSTEM_LIBS_PICOJSON} ${CONAN_FRAMEWORKS_FOUND_PICOJSON} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PICOJSON}" "${CONAN_LIB_DIRS_PICOJSON}"
                                  CONAN_PACKAGE_TARGETS_PICOJSON "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES}"
                                  "" picojson)
    set(_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_PICOJSON_DEBUG} ${CONAN_FRAMEWORKS_FOUND_PICOJSON_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PICOJSON_DEBUG}" "${CONAN_LIB_DIRS_PICOJSON_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_PICOJSON_DEBUG "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_DEBUG}"
                                  "debug" picojson)
    set(_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_PICOJSON_RELEASE} ${CONAN_FRAMEWORKS_FOUND_PICOJSON_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PICOJSON_RELEASE}" "${CONAN_LIB_DIRS_PICOJSON_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_PICOJSON_RELEASE "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELEASE}"
                                  "release" picojson)
    set(_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_PICOJSON_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_PICOJSON_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PICOJSON_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_PICOJSON_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_PICOJSON_RELWITHDEBINFO "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" picojson)
    set(_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_PICOJSON_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_PICOJSON_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PICOJSON_MINSIZEREL}" "${CONAN_LIB_DIRS_PICOJSON_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_PICOJSON_MINSIZEREL "${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" picojson)

    add_library(CONAN_PKG::picojson INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::picojson PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_PICOJSON} ${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PICOJSON_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_PICOJSON_RELEASE} ${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PICOJSON_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_PICOJSON_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PICOJSON_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_PICOJSON_MINSIZEREL} ${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PICOJSON_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_PICOJSON_DEBUG} ${_CONAN_PKG_LIBS_PICOJSON_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PICOJSON_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PICOJSON_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::picojson PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_PICOJSON}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_PICOJSON_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_PICOJSON_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_PICOJSON_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_PICOJSON_DEBUG}>)
    set_property(TARGET CONAN_PKG::picojson PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_PICOJSON}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_PICOJSON_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_PICOJSON_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_PICOJSON_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_PICOJSON_DEBUG}>)
    set_property(TARGET CONAN_PKG::picojson PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_PICOJSON_LIST} ${CONAN_CXX_FLAGS_PICOJSON_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_PICOJSON_RELEASE_LIST} ${CONAN_CXX_FLAGS_PICOJSON_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_PICOJSON_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_PICOJSON_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_PICOJSON_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_PICOJSON_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_PICOJSON_DEBUG_LIST}  ${CONAN_CXX_FLAGS_PICOJSON_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB}" "${CONAN_LIB_DIRS_ZLIB}"
                                  CONAN_PACKAGE_TARGETS_ZLIB "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}"
                                  "" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ZLIB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ZLIB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_DEBUG}" "${CONAN_LIB_DIRS_ZLIB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}"
                                  "debug" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ZLIB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELEASE}" "${CONAN_LIB_DIRS_ZLIB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}"
                                  "release" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ZLIB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ZLIB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ZLIB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ZLIB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_MINSIZEREL}" "${CONAN_LIB_DIRS_ZLIB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" zlib)

    add_library(CONAN_PKG::zlib INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ZLIB} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ZLIB_RELEASE} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ZLIB_DEBUG} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ZLIB_LIST} ${CONAN_CXX_FLAGS_ZLIB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ZLIB_RELEASE_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ZLIB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ZLIB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ZLIB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ZLIB_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES "${CONAN_SYSTEM_LIBS_BZIP2} ${CONAN_FRAMEWORKS_FOUND_BZIP2} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2}" "${CONAN_LIB_DIRS_BZIP2}"
                                  CONAN_PACKAGE_TARGETS_BZIP2 "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}"
                                  "" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_BZIP2_DEBUG} ${CONAN_FRAMEWORKS_FOUND_BZIP2_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_DEBUG}" "${CONAN_LIB_DIRS_BZIP2_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_DEBUG "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}"
                                  "debug" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_BZIP2_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_RELEASE}" "${CONAN_LIB_DIRS_BZIP2_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_RELEASE "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}"
                                  "release" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BZIP2_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BZIP2_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_BZIP2_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_BZIP2_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_MINSIZEREL}" "${CONAN_LIB_DIRS_BZIP2_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_MINSIZEREL "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" bzip2)

    add_library(CONAN_PKG::bzip2 INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BZIP2} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BZIP2_RELEASE} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BZIP2_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BZIP2_MINSIZEREL} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BZIP2_DEBUG} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BZIP2}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BZIP2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BZIP2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BZIP2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BZIP2_DEBUG}>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BZIP2}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BZIP2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BZIP2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BZIP2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BZIP2_DEBUG}>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BZIP2_LIST} ${CONAN_CXX_FLAGS_BZIP2_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BZIP2_RELEASE_LIST} ${CONAN_CXX_FLAGS_BZIP2_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BZIP2_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BZIP2_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BZIP2_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BZIP2_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBBACKTRACE} ${CONAN_FRAMEWORKS_FOUND_LIBBACKTRACE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBBACKTRACE}" "${CONAN_LIB_DIRS_LIBBACKTRACE}"
                                  CONAN_PACKAGE_TARGETS_LIBBACKTRACE "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES}"
                                  "" libbacktrace)
    set(_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBBACKTRACE_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBBACKTRACE_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBBACKTRACE_DEBUG}" "${CONAN_LIB_DIRS_LIBBACKTRACE_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBBACKTRACE_DEBUG "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_DEBUG}"
                                  "debug" libbacktrace)
    set(_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBBACKTRACE_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBBACKTRACE_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBBACKTRACE_RELEASE}" "${CONAN_LIB_DIRS_LIBBACKTRACE_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBBACKTRACE_RELEASE "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELEASE}"
                                  "release" libbacktrace)
    set(_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBBACKTRACE_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBBACKTRACE_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBBACKTRACE_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBBACKTRACE_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBBACKTRACE_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libbacktrace)
    set(_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBBACKTRACE_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBBACKTRACE_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBBACKTRACE_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBBACKTRACE_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBBACKTRACE_MINSIZEREL "${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libbacktrace)

    add_library(CONAN_PKG::libbacktrace INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libbacktrace PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBBACKTRACE} ${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBBACKTRACE_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBBACKTRACE_RELEASE} ${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBBACKTRACE_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBBACKTRACE_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBBACKTRACE_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBBACKTRACE_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBBACKTRACE_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBBACKTRACE_DEBUG} ${_CONAN_PKG_LIBS_LIBBACKTRACE_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBBACKTRACE_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBBACKTRACE_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libbacktrace PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBBACKTRACE}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBBACKTRACE_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBBACKTRACE_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBBACKTRACE_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBBACKTRACE_DEBUG}>)
    set_property(TARGET CONAN_PKG::libbacktrace PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBBACKTRACE}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBBACKTRACE_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBBACKTRACE_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBBACKTRACE_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBBACKTRACE_DEBUG}>)
    set_property(TARGET CONAN_PKG::libbacktrace PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBBACKTRACE_LIST} ${CONAN_CXX_FLAGS_LIBBACKTRACE_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBBACKTRACE_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBBACKTRACE_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBBACKTRACE_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBBACKTRACE_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBBACKTRACE_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBBACKTRACE_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBBACKTRACE_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBBACKTRACE_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBICONV} ${CONAN_FRAMEWORKS_FOUND_LIBICONV} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV}" "${CONAN_LIB_DIRS_LIBICONV}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES}"
                                  "" libiconv)
    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBICONV_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBICONV_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV_DEBUG}" "${CONAN_LIB_DIRS_LIBICONV_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV_DEBUG "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG}"
                                  "debug" libiconv)
    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBICONV_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBICONV_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV_RELEASE}" "${CONAN_LIB_DIRS_LIBICONV_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV_RELEASE "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE}"
                                  "release" libiconv)
    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBICONV_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBICONV_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBICONV_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libiconv)
    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBICONV_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBICONV_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBICONV_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV_MINSIZEREL "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libiconv)

    add_library(CONAN_PKG::libiconv INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libiconv PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBICONV} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBICONV_RELEASE} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBICONV_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBICONV_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBICONV_DEBUG} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libiconv PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBICONV}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBICONV_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBICONV_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBICONV_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBICONV_DEBUG}>)
    set_property(TARGET CONAN_PKG::libiconv PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBICONV}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBICONV_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBICONV_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBICONV_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBICONV_DEBUG}>)
    set_property(TARGET CONAN_PKG::libiconv PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBICONV_LIST} ${CONAN_CXX_FLAGS_LIBICONV_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBICONV_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBICONV_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBICONV_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBICONV_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBICONV_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBICONV_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBICONV_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBICONV_DEBUG_LIST}>)

    set(CONAN_TARGETS CONAN_PKG::pybind11 CONAN_PKG::opentdf-client CONAN_PKG::ms-gsl CONAN_PKG::nlohmann_json CONAN_PKG::jwt-cpp CONAN_PKG::boost CONAN_PKG::libxml2 CONAN_PKG::openssl CONAN_PKG::picojson CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::libbacktrace CONAN_PKG::libiconv)

endmacro()


macro(conan_basic_setup)
    set(options TARGETS NO_OUTPUT_DIRS SKIP_RPATH KEEP_RPATHS SKIP_STD SKIP_FPIC)
    cmake_parse_arguments(ARGUMENTS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    if(CONAN_EXPORTED)
        conan_message(STATUS "Conan: called by CMake conan helper")
    endif()

    if(CONAN_IN_LOCAL_CACHE)
        conan_message(STATUS "Conan: called inside local cache")
    endif()

    if(NOT ARGUMENTS_NO_OUTPUT_DIRS)
        conan_message(STATUS "Conan: Adjusting output directories")
        conan_output_dirs_setup()
    endif()

    if(NOT ARGUMENTS_TARGETS)
        conan_message(STATUS "Conan: Using cmake global configuration")
        conan_global_flags()
    else()
        conan_message(STATUS "Conan: Using cmake targets configuration")
        conan_define_targets()
    endif()

    if(ARGUMENTS_SKIP_RPATH)
        # Change by "DEPRECATION" or "SEND_ERROR" when we are ready
        conan_message(WARNING "Conan: SKIP_RPATH is deprecated, it has been renamed to KEEP_RPATHS")
    endif()

    if(NOT ARGUMENTS_SKIP_RPATH AND NOT ARGUMENTS_KEEP_RPATHS)
        # Parameter has renamed, but we keep the compatibility with old SKIP_RPATH
        conan_set_rpath()
    endif()

    if(NOT ARGUMENTS_SKIP_STD)
        conan_set_std()
    endif()

    if(NOT ARGUMENTS_SKIP_FPIC)
        conan_set_fpic()
    endif()

    conan_check_compiler()
    conan_set_libcxx()
    conan_set_vs_runtime()
    conan_set_find_paths()
    conan_include_build_modules()
    conan_set_find_library_paths()
endmacro()


macro(conan_set_find_paths)
    # CMAKE_MODULE_PATH does not have Debug/Release config, but there are variables
    # CONAN_CMAKE_MODULE_PATH_DEBUG to be used by the consumer
    # CMake can find findXXX.cmake files in the root of packages
    set(CMAKE_MODULE_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_MODULE_PATH})

    # Make find_package() to work
    set(CMAKE_PREFIX_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_PREFIX_PATH})

    # Set the find root path (cross build)
    set(CMAKE_FIND_ROOT_PATH ${CONAN_CMAKE_FIND_ROOT_PATH} ${CMAKE_FIND_ROOT_PATH})
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM)
        set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY)
        set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE)
        set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE})
    endif()
endmacro()


macro(conan_set_find_library_paths)
    # CMAKE_INCLUDE_PATH, CMAKE_LIBRARY_PATH does not have Debug/Release config, but there are variables
    # CONAN_INCLUDE_DIRS_DEBUG/RELEASE CONAN_LIB_DIRS_DEBUG/RELEASE to be used by the consumer
    # For find_library
    set(CMAKE_INCLUDE_PATH ${CONAN_INCLUDE_DIRS} ${CMAKE_INCLUDE_PATH})
    set(CMAKE_LIBRARY_PATH ${CONAN_LIB_DIRS} ${CMAKE_LIBRARY_PATH})
endmacro()


macro(conan_set_vs_runtime)
    if(CONAN_LINK_RUNTIME)
        conan_get_policy(CMP0091 policy_0091)
        if(policy_0091 STREQUAL "NEW")
            if(CONAN_LINK_RUNTIME MATCHES "MTd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug")
            elseif(CONAN_LINK_RUNTIME MATCHES "MDd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL")
            elseif(CONAN_LINK_RUNTIME MATCHES "MT")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
            elseif(CONAN_LINK_RUNTIME MATCHES "MD")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
            endif()
        else()
            foreach(flag CMAKE_C_FLAGS_RELEASE CMAKE_CXX_FLAGS_RELEASE
                         CMAKE_C_FLAGS_RELWITHDEBINFO CMAKE_CXX_FLAGS_RELWITHDEBINFO
                         CMAKE_C_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_MINSIZEREL)
                if(DEFINED ${flag})
                    string(REPLACE "/MD" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
            foreach(flag CMAKE_C_FLAGS_DEBUG CMAKE_CXX_FLAGS_DEBUG)
                if(DEFINED ${flag})
                    string(REPLACE "/MDd" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
        endif()
    endif()
endmacro()


macro(conan_flags_setup)
    # Macro maintained for backwards compatibility
    conan_set_find_library_paths()
    conan_global_flags()
    conan_set_rpath()
    conan_set_vs_runtime()
    conan_set_libcxx()
endmacro()


function(conan_message MESSAGE_OUTPUT)
    if(NOT CONAN_CMAKE_SILENT_OUTPUT)
        message(${ARGV${0}})
    endif()
endfunction()


function(conan_get_policy policy_id policy)
    if(POLICY "${policy_id}")
        cmake_policy(GET "${policy_id}" _policy)
        set(${policy} "${_policy}" PARENT_SCOPE)
    else()
        set(${policy} "" PARENT_SCOPE)
    endif()
endfunction()


function(conan_find_libraries_abs_path libraries package_libdir libraries_abs_path)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAMES ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${CONAN_FOUND_LIBRARY})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()
    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


function(conan_package_library_targets libraries package_libdir libraries_abs_path deps build_type package_name)
    unset(_CONAN_ACTUAL_TARGETS CACHE)
    unset(_CONAN_FOUND_SYSTEM_LIBS CACHE)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAMES ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(_LIB_NAME CONAN_LIB::${package_name}_${_LIBRARY_NAME}${build_type})
            add_library(${_LIB_NAME} UNKNOWN IMPORTED)
            set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIB_NAME})
            set(_CONAN_ACTUAL_TARGETS ${_CONAN_ACTUAL_TARGETS} ${_LIB_NAME})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
            set(_CONAN_FOUND_SYSTEM_LIBS "${_CONAN_FOUND_SYSTEM_LIBS};${_LIBRARY_NAME}")
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()

    # Add all dependencies to all targets
    string(REPLACE " " ";" deps_list "${deps}")
    foreach(_CONAN_ACTUAL_TARGET ${_CONAN_ACTUAL_TARGETS})
        set_property(TARGET ${_CONAN_ACTUAL_TARGET} PROPERTY INTERFACE_LINK_LIBRARIES "${_CONAN_FOUND_SYSTEM_LIBS};${deps_list}")
    endforeach()

    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


macro(conan_set_libcxx)
    if(DEFINED CONAN_LIBCXX)
        conan_message(STATUS "Conan: C++ stdlib: ${CONAN_LIBCXX}")
        if(CONAN_COMPILER STREQUAL "clang" OR CONAN_COMPILER STREQUAL "apple-clang")
            if(CONAN_LIBCXX STREQUAL "libstdc++" OR CONAN_LIBCXX STREQUAL "libstdc++11" )
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
            elseif(CONAN_LIBCXX STREQUAL "libc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
            endif()
        endif()
        if(CONAN_COMPILER STREQUAL "sun-cc")
            if(CONAN_LIBCXX STREQUAL "libCstd")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=Cstd")
            elseif(CONAN_LIBCXX STREQUAL "libstdcxx")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcxx4")
            elseif(CONAN_LIBCXX STREQUAL "libstlport")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stlport4")
            elseif(CONAN_LIBCXX STREQUAL "libstdc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcpp")
            endif()
        endif()
        if(CONAN_LIBCXX STREQUAL "libstdc++11")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)
        elseif(CONAN_LIBCXX STREQUAL "libstdc++")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=0)
        endif()
    endif()
endmacro()


macro(conan_set_std)
    conan_message(STATUS "Conan: Adjusting language standard")
    # Do not warn "Manually-specified variables were not used by the project"
    set(ignorevar "${CONAN_STD_CXX_FLAG}${CONAN_CMAKE_CXX_STANDARD}${CONAN_CMAKE_CXX_EXTENSIONS}")
    if (CMAKE_VERSION VERSION_LESS "3.1" OR
        (CMAKE_VERSION VERSION_LESS "3.12" AND ("${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "20" OR "${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "gnu20")))
        if(CONAN_STD_CXX_FLAG)
            conan_message(STATUS "Conan setting CXX_FLAGS flags: ${CONAN_STD_CXX_FLAG}")
            set(CMAKE_CXX_FLAGS "${CONAN_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}")
        endif()
    else()
        if(CONAN_CMAKE_CXX_STANDARD)
            conan_message(STATUS "Conan setting CPP STANDARD: ${CONAN_CMAKE_CXX_STANDARD} WITH EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS}")
            set(CMAKE_CXX_STANDARD ${CONAN_CMAKE_CXX_STANDARD})
            set(CMAKE_CXX_EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS})
        endif()
    endif()
endmacro()


macro(conan_set_rpath)
    conan_message(STATUS "Conan: Adjusting default RPATHs Conan policies")
    if(APPLE)
        # https://cmake.org/Wiki/CMake_RPATH_handling
        # CONAN GUIDE: All generated libraries should have the id and dependencies to other
        # dylibs without path, just the name, EX:
        # libMyLib1.dylib:
        #     libMyLib1.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     libMyLib0.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 120.0.0)
        #     /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1197.1.1)
        # AVOID RPATH FOR *.dylib, ALL LIBS BETWEEN THEM AND THE EXE
        # SHOULD BE ON THE LINKER RESOLVER PATH (./ IS ONE OF THEM)
        set(CMAKE_SKIP_RPATH 1 CACHE BOOL "rpaths" FORCE)
        # Policy CMP0068
        # We want the old behavior, in CMake >= 3.9 CMAKE_SKIP_RPATH won't affect the install_name in OSX
        set(CMAKE_INSTALL_NAME_DIR "")
    endif()
endmacro()


macro(conan_set_fpic)
    if(DEFINED CONAN_CMAKE_POSITION_INDEPENDENT_CODE)
        conan_message(STATUS "Conan: Adjusting fPIC flag (${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})")
        set(CMAKE_POSITION_INDEPENDENT_CODE ${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})
    endif()
endmacro()


macro(conan_output_dirs_setup)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
endmacro()


macro(conan_split_version VERSION_STRING MAJOR MINOR)
    #make a list from the version string
    string(REPLACE "." ";" VERSION_LIST "${VERSION_STRING}")

    #write output values
    list(LENGTH VERSION_LIST _version_len)
    list(GET VERSION_LIST 0 ${MAJOR})
    if(${_version_len} GREATER 1)
        list(GET VERSION_LIST 1 ${MINOR})
    endif()
endmacro()


macro(conan_error_compiler_version)
    message(FATAL_ERROR "Detected a mismatch for the compiler version between your conan profile settings and CMake: \n"
                        "Compiler version specified in your conan profile: ${CONAN_COMPILER_VERSION}\n"
                        "Compiler version detected in CMake: ${VERSION_MAJOR}.${VERSION_MINOR}\n"
                        "Please check your conan profile settings (conan profile show [default|your_profile_name])\n"
                        "P.S. You may set CONAN_DISABLE_CHECK_COMPILER CMake variable in order to disable this check."
           )
endmacro()

set(_CONAN_CURRENT_DIR ${CMAKE_CURRENT_LIST_DIR})

function(conan_get_compiler CONAN_INFO_COMPILER CONAN_INFO_COMPILER_VERSION)
    conan_message(STATUS "Current conanbuildinfo.cmake directory: " ${_CONAN_CURRENT_DIR})
    if(NOT EXISTS ${_CONAN_CURRENT_DIR}/conaninfo.txt)
        conan_message(STATUS "WARN: conaninfo.txt not found")
        return()
    endif()

    file (READ "${_CONAN_CURRENT_DIR}/conaninfo.txt" CONANINFO)

    # MATCHALL will match all, including the last one, which is the full_settings one
    string(REGEX MATCH "full_settings.*" _FULL_SETTINGS_MATCHED ${CONANINFO})
    string(REGEX MATCH "compiler=([-A-Za-z0-9_ ]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER)
        set(${CONAN_INFO_COMPILER} ${_CONAN_INFO_COMPILER} PARENT_SCOPE)
    endif()

    string(REGEX MATCH "compiler.version=([-A-Za-z0-9_.]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER_VERSION)
        set(${CONAN_INFO_COMPILER_VERSION} ${_CONAN_INFO_COMPILER_VERSION} PARENT_SCOPE)
    endif()
endfunction()


function(check_compiler_version)
    conan_split_version(${CMAKE_CXX_COMPILER_VERSION} VERSION_MAJOR VERSION_MINOR)
    if(DEFINED CONAN_SETTINGS_COMPILER_TOOLSET)
       conan_message(STATUS "Conan: Skipping compiler check: Declared 'compiler.toolset'")
       return()
    endif()
    if(CMAKE_CXX_COMPILER_ID MATCHES MSVC)
        # MSVC_VERSION is defined since 2.8.2 at least
        # https://cmake.org/cmake/help/v2.8.2/cmake.html#variable:MSVC_VERSION
        # https://cmake.org/cmake/help/v3.14/variable/MSVC_VERSION.html
        if(
            # 1930 = VS 17.0 (v143 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "17" AND NOT((MSVC_VERSION EQUAL 1930) OR (MSVC_VERSION GREATER 1930))) OR
            # 1920-1929 = VS 16.0 (v142 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "16" AND NOT((MSVC_VERSION GREATER 1919) AND (MSVC_VERSION LESS 1930))) OR
            # 1910-1919 = VS 15.0 (v141 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "15" AND NOT((MSVC_VERSION GREATER 1909) AND (MSVC_VERSION LESS 1920))) OR
            # 1900      = VS 14.0 (v140 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "14" AND NOT(MSVC_VERSION EQUAL 1900)) OR
            # 1800      = VS 12.0 (v120 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "12" AND NOT VERSION_MAJOR STREQUAL "18") OR
            # 1700      = VS 11.0 (v110 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "11" AND NOT VERSION_MAJOR STREQUAL "17") OR
            # 1600      = VS 10.0 (v100 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "10" AND NOT VERSION_MAJOR STREQUAL "16") OR
            # 1500      = VS  9.0 (v90 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "9" AND NOT VERSION_MAJOR STREQUAL "15") OR
            # 1400      = VS  8.0 (v80 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "8" AND NOT VERSION_MAJOR STREQUAL "14") OR
            # 1310      = VS  7.1, 1300      = VS  7.0
            (CONAN_COMPILER_VERSION STREQUAL "7" AND NOT VERSION_MAJOR STREQUAL "13") OR
            # 1200      = VS  6.0
            (CONAN_COMPILER_VERSION STREQUAL "6" AND NOT VERSION_MAJOR STREQUAL "12") )
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "gcc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 5.0)
            conan_message(STATUS "Conan: Compiler GCC>=5, checking major version ${CONAN_COMPILER_VERSION}")
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
                set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL ${_CONAN_VERSION})
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "clang")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 8.0)
            conan_message(STATUS "Conan: Compiler Clang>=8, checking major version ${CONAN_COMPILER_VERSION}")
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
                set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL ${_CONAN_VERSION})
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "apple-clang" OR CONAN_COMPILER STREQUAL "sun-cc" OR CONAN_COMPILER STREQUAL "mcst-lcc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(${CONAN_COMPILER_MAJOR} VERSION_GREATER_EQUAL "13" AND "${CONAN_COMPILER_MINOR}" STREQUAL "" AND ${CONAN_COMPILER_MAJOR} VERSION_EQUAL ${VERSION_MAJOR})
           # This is correct,  13.X is considered 13
        elseif(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
           conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "intel")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 19.1)
            if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
               conan_error_compiler_version()
            endif()
        else()
            if(NOT ${VERSION_MAJOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR})
               conan_error_compiler_version()
            endif()
        endif()
    else()
        conan_message(STATUS "WARN: Unknown compiler '${CONAN_COMPILER}', skipping the version check...")
    endif()
endfunction()


function(conan_check_compiler)
    if(CONAN_DISABLE_CHECK_COMPILER)
        conan_message(STATUS "WARN: Disabled conan compiler checks")
        return()
    endif()
    if(NOT DEFINED CMAKE_CXX_COMPILER_ID)
        if(DEFINED CMAKE_C_COMPILER_ID)
            conan_message(STATUS "This project seems to be plain C, using '${CMAKE_C_COMPILER_ID}' compiler")
            set(CMAKE_CXX_COMPILER_ID ${CMAKE_C_COMPILER_ID})
            set(CMAKE_CXX_COMPILER_VERSION ${CMAKE_C_COMPILER_VERSION})
        else()
            message(FATAL_ERROR "This project seems to be plain C, but no compiler defined")
        endif()
    endif()
    if(NOT CMAKE_CXX_COMPILER_ID AND NOT CMAKE_C_COMPILER_ID)
        # This use case happens when compiler is not identified by CMake, but the compilers are there and work
        conan_message(STATUS "*** WARN: CMake was not able to identify a C or C++ compiler ***")
        conan_message(STATUS "*** WARN: Disabling compiler checks. Please make sure your settings match your environment ***")
        return()
    endif()
    if(NOT DEFINED CONAN_COMPILER)
        conan_get_compiler(CONAN_COMPILER CONAN_COMPILER_VERSION)
        if(NOT DEFINED CONAN_COMPILER)
            conan_message(STATUS "WARN: CONAN_COMPILER variable not set, please make sure yourself that "
                          "your compiler and version matches your declared settings")
            return()
        endif()
    endif()

    if(NOT CMAKE_HOST_SYSTEM_NAME STREQUAL ${CMAKE_SYSTEM_NAME})
        set(CROSS_BUILDING 1)
    endif()

    # If using VS, verify toolset
    if (CONAN_COMPILER STREQUAL "Visual Studio")
        if (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "LLVM" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "llvm" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "clang" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Clang")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Clang")
        elseif (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Intel")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Intel")
        else()
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "MSVC")
        endif()

        if (NOT CMAKE_CXX_COMPILER_ID MATCHES ${EXPECTED_CMAKE_CXX_COMPILER_ID})
            message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}'. Toolset specifies compiler as '${EXPECTED_CMAKE_CXX_COMPILER_ID}' "
                                "but CMake detected '${CMAKE_CXX_COMPILER_ID}'")
        endif()

    # Avoid checks when cross compiling, apple-clang crashes because its APPLE but not apple-clang
    # Actually CMake is detecting "clang" when you are using apple-clang, only if CMP0025 is set to NEW will detect apple-clang
    elseif((CONAN_COMPILER STREQUAL "gcc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU") OR
        (CONAN_COMPILER STREQUAL "apple-clang" AND NOT CROSS_BUILDING AND (NOT APPLE OR NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")) OR
        (CONAN_COMPILER STREQUAL "clang" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang") OR
        (CONAN_COMPILER STREQUAL "sun-cc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "SunPro") )
        message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}', is not the one detected by CMake: '${CMAKE_CXX_COMPILER_ID}'")
    endif()


    if(NOT DEFINED CONAN_COMPILER_VERSION)
        conan_message(STATUS "WARN: CONAN_COMPILER_VERSION variable not set, please make sure yourself "
                             "that your compiler version matches your declared settings")
        return()
    endif()
    check_compiler_version()
endfunction()


macro(conan_set_flags build_type)
    set(CMAKE_CXX_FLAGS${build_type} "${CMAKE_CXX_FLAGS${build_type}} ${CONAN_CXX_FLAGS${build_type}}")
    set(CMAKE_C_FLAGS${build_type} "${CMAKE_C_FLAGS${build_type}} ${CONAN_C_FLAGS${build_type}}")
    set(CMAKE_SHARED_LINKER_FLAGS${build_type} "${CMAKE_SHARED_LINKER_FLAGS${build_type}} ${CONAN_SHARED_LINKER_FLAGS${build_type}}")
    set(CMAKE_EXE_LINKER_FLAGS${build_type} "${CMAKE_EXE_LINKER_FLAGS${build_type}} ${CONAN_EXE_LINKER_FLAGS${build_type}}")
endmacro()


macro(conan_global_flags)
    if(CONAN_SYSTEM_INCLUDES)
        include_directories(SYSTEM ${CONAN_INCLUDE_DIRS}
                                   "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                                   "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                                   "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                                   "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    else()
        include_directories(${CONAN_INCLUDE_DIRS}
                            "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                            "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                            "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                            "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    endif()

    link_directories(${CONAN_LIB_DIRS})

    conan_find_libraries_abs_path("${CONAN_LIBS_DEBUG}" "${CONAN_LIB_DIRS_DEBUG}"
                                  CONAN_LIBS_DEBUG)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELEASE}" "${CONAN_LIB_DIRS_RELEASE}"
                                  CONAN_LIBS_RELEASE)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_RELWITHDEBINFO}"
                                  CONAN_LIBS_RELWITHDEBINFO)
    conan_find_libraries_abs_path("${CONAN_LIBS_MINSIZEREL}" "${CONAN_LIB_DIRS_MINSIZEREL}"
                                  CONAN_LIBS_MINSIZEREL)

    add_compile_options(${CONAN_DEFINES}
                        "$<$<CONFIG:Debug>:${CONAN_DEFINES_DEBUG}>"
                        "$<$<CONFIG:Release>:${CONAN_DEFINES_RELEASE}>"
                        "$<$<CONFIG:RelWithDebInfo>:${CONAN_DEFINES_RELWITHDEBINFO}>"
                        "$<$<CONFIG:MinSizeRel>:${CONAN_DEFINES_MINSIZEREL}>")

    conan_set_flags("")
    conan_set_flags("_RELEASE")
    conan_set_flags("_DEBUG")

endmacro()


macro(conan_target_link_libraries target)
    if(CONAN_TARGETS)
        target_link_libraries(${target} ${CONAN_TARGETS})
    else()
        target_link_libraries(${target} ${CONAN_LIBS})
        foreach(_LIB ${CONAN_LIBS_RELEASE})
            target_link_libraries(${target} optimized ${_LIB})
        endforeach()
        foreach(_LIB ${CONAN_LIBS_DEBUG})
            target_link_libraries(${target} debug ${_LIB})
        endforeach()
    endif()
endmacro()


macro(conan_include_build_modules)
    if(CMAKE_BUILD_TYPE)
        if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_DEBUG} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "Release")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELEASE} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "RelWithDebInfo")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELWITHDEBINFO} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "MinSizeRel")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_MINSIZEREL} ${CONAN_BUILD_MODULES_PATHS})
        endif()
    endif()

    foreach(_BUILD_MODULE_PATH ${CONAN_BUILD_MODULES_PATHS})
        include(${_BUILD_MODULE_PATH})
    endforeach()
endmacro()


### Definition of user declared vars (user_info) ###

set(CONAN_USER_BOOST_stacktrace_addr2line_available "True")