# Install script for directory: /Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Users/vheneraliuk/Library/Android/sdk/ndk/25.2.9519653/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp" TYPE DIRECTORY FILES "")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_client.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_client.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_encrypt_file_params.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_encrypt_file_params.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_encrypt_data_params.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_encrypt_data_params.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_encrypt_stream_params.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_encrypt_stream_params.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_encrypt_string_params.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_encrypt_string_params.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_encrypt_params.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_encrypt_params.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_tdf3_constants.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_tdf3_constants.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_client_config.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_client_config.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_credentials_hmac.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_credentials_hmac.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_credentials_appid.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_credentials_appid.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_credentials_oidc.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_credentials_oidc.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_policy.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_policy.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_credentials.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_credentials.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/tdf_constants.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/include/tdf_constants.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/network_interface.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/include/network_interface.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/tdf_exception.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/include/tdf_exception.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/tdf_logging_interface.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/.conan/data/opentdf-client/1.3.10/_/_/package/deb762254fa6aecb8a54a0ce382ac75288d5bffd/include/tdf_logging_interface.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_audit_service.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_audit_service.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_config_service.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_config_service.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_client_c.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_client_c.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_constants_c.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_constants_c.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_encrypt_file_params_c.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_encrypt_file_params_c.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_encrypt_string_params_c.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_encrypt_string_params_c.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include/virtru_policy_c.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/include" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/include/virtru_policy_c.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/lib/libvirtru_tdf3_static.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/lib" TYPE PROGRAM FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/android/.outputs/Debug/6x4f3h3i/arm64-v8a/lib/libvirtru_tdf3_static.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/lib/libvirtru_tdf3.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/lib" TYPE PROGRAM FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/android/.outputs/Debug/6x4f3h3i/arm64-v8a/lib/libvirtru_tdf3.so")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/LICENSE")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../LICENSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/cpp-sample/CMakeLists.txt")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/cpp-sample" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-cpp-sample/CMakeLists.txt")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/cpp-sample/virtru_sample.cpp")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/cpp-sample" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-cpp-sample/virtru_sample.cpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/c-sample/CMakeLists.txt")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/c-sample" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-c-sample/CMakeLists.txt")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/c-sample/virtru_sample.c")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/c-sample" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-c-sample/virtru_sample.c")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/VERSION")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../VERSION")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp/README.md")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/../../virtru-tdf3-lib-cpp" TYPE FILE FILES "/Users/vheneraliuk/workspace/virtru_sdk_flutter/src/virtru-tdf3-src/lib/README.md")
endif()

