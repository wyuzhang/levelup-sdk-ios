#!/bin/bash

# Adapted from scripts in https://github.com/jverkoey/iOS-Framework

# Build the Pods, then namespace all its symbols into a header
function setup_namespaces {
  header=$SRCROOT/Pods/NamespacedDependencies.h

  # Clear header
  cat /dev/null > $header

  # Build Pods
  xcrun xcodebuild -project "${PROJECT_DIR}/Pods/Pods.xcodeproj" -target "Pods" -sdk "${SDK_NAME}" -configuration "${CONFIGURATION}" BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" SYMROOT="${SYMROOT}" clean $ACTION

  # Make header file with all symbols namespaced
  LIB_PATH="${BUILT_PRODUCTS_DIR}/libPods.a"

  echo "Generating $header from $LIB_PATH..."

cat << 'EOF' > $header
/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Namespaced Header

#define LEVELUP_EXTERNAL_PREFIX LEVELUPSDK

#define LUNS_impl2(prefix, symbol) prefix ## symbol
#define LUNS_impl(prefix, symbol) LUNS_impl2(prefix, symbol)
#define LUNS(symbol) LUNS_impl(LEVELUP_EXTERNAL_PREFIX, symbol)
EOF

  echo "// Classes" >> $header

  nm $LIB_PATH -j | sort | uniq | grep "_OBJC_CLASS_\$_" | grep -v "\$_AGSGT" | grep -v "\$_AV" | grep -v "\$_CA" | grep -v "\$_CL" | grep -v "\$_NS" | grep -v "\$_UI" | sed -e 's/_OBJC_CLASS_\$_\(.*\)/#ifndef \1\'$'\n''#define \1 LUNS(\1)\'$'\n''#endif\'$'\n''/g' >> $header

  echo "// Functions" >> $header

  nm $LIB_PATH | sort | uniq | grep " T " | cut -d' ' -f3 | grep -v "\$_NS" | grep -v "\$_UI" | sed -e 's/_\(.*\)/#ifndef \1\'$'\n''#define \1 LUNS(\1)\'$'\n''#endif\'$'\n''/g' >> $header

  echo "// Externs" >> $header

  nm $LIB_PATH | sort | uniq | grep " D " | cut -d' ' -f3 | grep -v "\$_NS" | grep -v "\$_UI" | sed -e 's/_\(.*\)/#ifndef \1\'$'\n''#define \1 LUNS(\1)\'$'\n''#endif\'$'\n''/g' >> $header

  nm $LIB_PATH | sort | uniq | grep " S " | cut -d' ' -f3 | grep -v "\$_NS" | grep -v ".eh" | grep -v "\$_UI" | grep -v "OBJC_" | sed -e 's/_\(.*\)/#ifndef \1\'$'\n''#define \1 LUNS(\1)\'$'\n''#endif\'$'\n''/g' >> $header
}

# Build the library for both the simulator and iOS
function build_library_on_all_platforms {
  # Determine the platform not currently selected (i.e. if "iphonesimulator7.1" is selected, we also want "iphoneos7.1")
  if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]
  then
      SF_SDK_PLATFORM=${BASH_REMATCH[1]}
  else
      echo "Could not find platform name from SDK_NAME: $SDK_NAME"
      exit 1
  fi

  if [[ "$SDK_NAME" =~ ([0-9]+.*$) ]]
  then
      SF_SDK_VERSION=${BASH_REMATCH[1]}
  else
      echo "Could not find sdk version from SDK_NAME: $SDK_NAME"
      exit 1
  fi

  if [[ "$SF_SDK_PLATFORM" = "iphoneos" ]]
  then
      SF_OTHER_PLATFORM=iphonesimulator
  else
      SF_OTHER_PLATFORM=iphoneos
  fi

  if [[ "$BUILT_PRODUCTS_DIR" =~ (.*)$SF_SDK_PLATFORM$ ]]
  then
      SF_OTHER_BUILT_PRODUCTS_DIR="${BASH_REMATCH[1]}${SF_OTHER_PLATFORM}"
  else
      echo "Could not find platform name from build products directory: $BUILT_PRODUCTS_DIR"
      exit 1
  fi

  # Build for both platforms
  SF_ALL_SDKS=("${SDK_NAME}" "${SF_OTHER_PLATFORM}${SF_SDK_VERSION}")
  for SF_SDK in "${SF_ALL_SDKS[@]}"
  do
    xcrun xcodebuild ONLY_ACTIVE_ARCH=NO VALID_ARCHS="armv7 armv7s arm64 i386 x86_64" \
      -workspace "${PROJECT_DIR}/${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT_NAME}" \
      -configuration "${CONFIGURATION}" -sdk "${SF_SDK}" BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" \
      BUILD_ROOT="${BUILD_ROOT}" SYMROOT="${SYMROOT}" GCC_PREPROCESSOR_DEFINITIONS="LU_NAMESPACED_DEPENDENCIES=1" \
      clean $ACTION
  done

  # Build bundle
  xcrun xcodebuild -workspace "${PROJECT_DIR}/${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT_NAME}Bundle" \
    -configuration "${CONFIGURATION}" -sdk "${SDK_NAME}" BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" \
    BUILD_ROOT="${BUILD_ROOT}" SYMROOT="${SYMROOT}" GCC_PREPROCESSOR_DEFINITIONS="LU_NAMESPACED_DEPENDENCIES=1" \
    clean $ACTION
}

function create_framework {
  SF_TARGET_NAME=${PROJECT_NAME}
  SF_EXECUTABLE_PATH="lib${SF_TARGET_NAME}.a"
  SF_WRAPPER_NAME="${SF_TARGET_NAME}.embeddedframework/${SF_TARGET_NAME}.framework"

  rm -rf "${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}"
  mkdir -p "${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}/Versions/A/Headers"

  # Link the "Current" version
  /bin/ln -sfh A "${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}/Versions/Current"
  /bin/ln -sfh Versions/Current/Headers "${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}/Headers"
  /bin/ln -sfh "Versions/Current/${SF_TARGET_NAME}" "${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}/${SF_TARGET_NAME}"

  /bin/cp -a "${TARGET_BUILD_DIR}/${PUBLIC_HEADERS_FOLDER_PATH}/" "${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}/Versions/A/Headers"

  # Smash the two static libraries into one fat binary and store it in the .framework
  xcrun lipo -create "${BUILT_PRODUCTS_DIR}/${SF_EXECUTABLE_PATH}" "${SF_OTHER_BUILT_PRODUCTS_DIR}/${SF_EXECUTABLE_PATH}" -output "${BUILT_PRODUCTS_DIR}/${SF_WRAPPER_NAME}/Versions/A/${SF_TARGET_NAME}"

  mkdir "${BUILT_PRODUCTS_DIR}/${SF_TARGET_NAME}.embeddedframework/Resources"
  cp -r "${BUILT_PRODUCTS_DIR}/${PROJECT_NAME}.bundle" "${BUILT_PRODUCTS_DIR}/${SF_TARGET_NAME}.embeddedframework/Resources"

  open "${BUILT_PRODUCTS_DIR}"
}

set -e
set +u

# Avoid recursively calling this script.
if [[ $SF_MASTER_SCRIPT_RUNNING ]]
then
  exit 0
fi

set -u
export SF_MASTER_SCRIPT_RUNNING=1

setup_namespaces
build_library_on_all_platforms
create_framework
