#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=viva
VENDOR=xiaomi
export PATCHELF_VERSION="0_17_2"
export EU_ENABLE_BINARY_CHECKS="true" # Enabled shared_libs, symbols and soname checks

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
    -n | --no-cleanup)
        CLEAN_VENDOR=false
        ;;
    -k | --kang)
        KANG="--kang"
        ;;
    -s | --section)
        SECTION="${2}"
        shift
        CLEAN_VENDOR=false
        ;;
    *)
        SRC="${1}"
        ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
    vendor/bin/hw/vendor.mediatek.hardware.mtkpower@1.0-service)
        "${PATCHELF}" --replace-needed "android.hardware.power-V2-ndk_platform.so" "android.hardware.power-V2-ndk.so" "${2}"
        ;;
    vendor/lib/hw/vendor.mediatek.hardware.pq@2.13-impl.so)
        ;&
    vendor/lib64/hw/vendor.mediatek.hardware.pq@2.13-impl.so)
        "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${2}"
        ;;
    vendor/lib64/libmtkcam_stdutils.so)
        "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${2}"
        ;;
    vendor/bin/hw/android.hardware.media.c2@1.2-mediatek)
        ;&
    vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b)
        "${PATCHELF}" --replace-needed "libavservices_minijail_vendor.so" "libavservices_minijail.so" "${2}"
        ;;
    vendor/etc/init/vendor.mediatek.hardware.mtkpower@1.0-service.rc)
        echo "$(cat ${2}) input" > "${2}"
        ;;
    vendor/lib*/hw/gralloc.mt6781.so|\
    vendor/lib*/libnotifyaudiohal.so|\
    vendor/lib64/libnir_neon_driver_ndk.mtk.vndk.so|\
    vendor/lib64/hw/fingerprint.*.mt6781.so|\
    vendor/lib*/hw/memtrack.mt6781.so|\
    vendor/lib64/hw/power.mt6781.so|\
    vendor/lib64/hw/sensors.elliptic.so|\
    vendor/lib/hw/sound_trigger.primary.mt6781.so|\
    vendor/lib*/libspeech_enh_lib.so)
        "${PATCHELF}" --set-soname "$(basename "${1}")" "${2}"
        ;;
    vendor/lib64/lib3a.sensors.flicker.so|\
    vendor/lib64/lib3a.sensors.color.so|\
    vendor/lib64/lib3a.ae.stat.so|\
    vendor/lib64/lib3a.flash.so|\
    vendor/lib64/libteei_daemon_vfs.so|\
    vendor/lib64/libaaa_ltm.so|\
    vendor/lib64/libSQLiteModule_VER_ALL.so)
        "${PATCHELF}" --add-needed "liblog.so" "${2}"
        ;;
    vendor/lib64/libmnl.so)
        "${PATCHELF}" --add-needed "libcutils.so" "${2}"
        ;;
    esac
}


# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"

vndk_import "${ANDROID_ROOT}" "libutils" "32" "both" "vndk-sp"
