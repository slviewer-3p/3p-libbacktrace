#!/bin/bash

cd "$(dirname "$0")"

set -xe

if [ -z "$AUTOBUILD" ] ; then
    fail
fi

SOURCE_DIR="libbacktrace"

# load autbuild provided shell functions and variables
eval "$("$AUTOBUILD" source_environment)"

top="$(pwd)"
stage="$(pwd)/stage"


case "$AUTOBUILD_PLATFORM" in
        "linux64")

			cd ${top}/${SOURCE_DIR}
			./configure
			make -j6

			mkdir -p ${stage}/include/
			mkdir -p ${stage}/lib/release/
			mkdir -p ${stage}/LICENSES/

			cp backtrace.h ${stage}/include/
			
			cp .libs/* ${stage}/lib/release/
			echo "1.0" > ${stage}/VERSION.txt
			cp LICENSE ${stage}/LICENSES/libbacktrace.txt
			;;
		*)
			echo "Unsupported platform ${AUTOBUILD_PLATFORM}"
			exit 1
			;;
		esac
