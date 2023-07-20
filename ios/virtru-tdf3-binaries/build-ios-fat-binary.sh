#!/bin/bash

set -ex

#
# Script to combine ios arm64 and ios simulator frameworks into a single xcframework containing all
#
# Pat Mancuso - 2021/01/08
#

FLAVORS=(
  "iphoneos-arm64"
  "iphonesimulator-x86_64"
  "iphonesimulator-arm64"
)

LIBNAME="virtru_tdf3"
DISTDIR="dist"
FRAMEWORKS_COMMAND="-framework iphoneos-arm64/${LIBNAME}.framework"

for FLAVOR in "${FLAVORS[@]}"; do
  echo "Processing ${FLAVOR}"
  tar xvf virtru-tdf3-lib-cpp-${FLAVOR}.tar.gz
  mkdir -p ${FLAVOR}
  cp -R virtru-tdf3-lib-cpp/lib/${LIBNAME}.framework ${FLAVOR}
  rm -rf virtru-tdf3-lib-cpp
done

mkdir -p iphonesimulator-universal/${LIBNAME}.framework

echo "Creating fat lib for iOS simulators"
lipo -create iphonesimulator-*/${LIBNAME}.framework/${LIBNAME} -output iphonesimulator-universal/${LIBNAME}.framework/${LIBNAME}

cp iphonesimulator-arm64/${LIBNAME}.framework/Info.plist iphonesimulator-universal/${LIBNAME}.framework

FRAMEWORKS_COMMAND="$FRAMEWORKS_COMMAND -framework iphonesimulator-universal/${LIBNAME}.framework"

echo "Removing old xcframework if exist"
rm -rf ${LIBNAME}.xcframework

echo "Creating xcframework"
xcodebuild -create-xcframework ${FRAMEWORKS_COMMAND} -output ${LIBNAME}.xcframework

for FLAVOR in "${FLAVORS[@]}"; do
 rm -rf ${FLAVOR}
done

rm -rf iphonesimulator-universal

echo "xcframowork created"
