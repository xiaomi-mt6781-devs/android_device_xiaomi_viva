#
# Copyright (C) 2022 ArrowOS
#
# SPDX-License-Identifier: Apache-2.0
#

KERNEL_PATH := device/xiaomi/viva-kernel
VENDOR_PATH := vendor/xiaomi/viva/proprietary

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Dalvik configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 30

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 32

## FastbootD
PRODUCT_PACKAGES += \
	fastbootd \
	android.hardware.fastboot@1.1-impl-mock

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS := \
	boot \
	system \
	vendor \
	product \
    vbmeta \
    vbmeta_system

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Display Resolution
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Display Density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
TARGET_SCREEN_DENSITY := 440

# Audio configs
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/configs/audio/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(file))) )

# Media configs
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/configs/media/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(file))) )

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video_le.xml

# Props
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/configs/props/boardid/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/boardid_props/, $(notdir $(file))) )

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
    $(LOCAL_PATH)/configs/permissions/com.fingerprints.extension.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.fingerprints.extension.xml

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio.service.mediatek \
    android.hardware.audio@7.0-impl \
    android.hardware.audio@6.0.vendor \
    android.hardware.audio@7.0-util.vendor \
    android.hardware.audio.common@5.0.vendor \
    android.hardware.audio.common@6.0.vendor \
    android.hardware.audio.common@6.0-util.vendor \
    android.hardware.audio.common@7.0.vendor \
    android.hardware.audio.common@7.0-enums.vendor \
    android.hardware.audio.common@7.0-util.vendor \
    android.hardware.audio.common-util.vendor \
    android.hardware.audio.effect@6.0-impl \
    android.hardware.audio.effect@7.0-impl \
    audio.primary.default \
    audio.r_submix.default \
    audio.usb.default \
    audio_policy.stub \
    libalsautils.vendor \
    libaudiofoundation.vendor \
    libavservices_minijail.vendor \
    libbluetooth_audio_session.vendor \
    tinymix

# In call service
PRODUCT_PACKAGES += \
    MtkInCallService

# Binder
PRODUCT_PACKAGES += \
    libhidltransport \
    libhidltransport.vendor \
    android.hidl.allocator@1.0 \
    android.hidl.memory.block@1.0 \
    libhwbinder \
    libhwbinder.vendor

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-mtkimpl:64 \
    android.hardware.boot@1.2-mtkimpl.recovery

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0.vendor \
    android.hardware.bluetooth@1.1.vendor \
    audio.bluetooth.default \
	android.hardware.bluetooth.audio-impl

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.common@1.0.vendor:64 \
    android.hardware.camera.device@1.0.vendor:64 \
    android.hardware.camera.device@3.2.vendor:64 \
    android.hardware.camera.device@3.3.vendor:64 \
    android.hardware.camera.device@3.4.vendor:64 \
    android.hardware.camera.device@3.5.vendor:64 \
    android.hardware.camera.device@3.6.vendor:64 \
    android.hardware.camera.provider@2.4.vendor:64 \
    android.hardware.camera.provider@2.5.vendor:64 \
    android.hardware.camera.provider@2.6.vendor:64

# CAS
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2-service-lazy

# Display
PRODUCT_PACKAGES += \
    libhwc2on1adapter.vendor \
    libhwc2onfbadapter.vendor \
    libdrm.vendor \
	android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.composer@2.1.vendor \
    android.hardware.graphics.composer@2.1-resources.vendor

# VNDK 32 libs
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v32/arm/arch-arm-armv7-a-neon/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libutils-v32.so \
    prebuilts/vndk/v32/arm64/arch-arm64-armv8-a/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libutils-v32.so \
	prebuilts/vndk/v32/arm64/arch-arm64-armv8-a/shared/vndk-core/libcrypto.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libcrypto-v32.so

# DRM
PRODUCT_PACKAGES += \
	android.hardware.drm@1.0.vendor \
	android.hardware.drm@1.1.vendor \
	android.hardware.drm@1.2.vendor \
	android.hardware.drm@1.3.vendor \
	android.hardware.drm@1.4.vendor \
    android.hardware.drm-service.clearkey

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi

# FMRadio
PRODUCT_PACKAGES += \
	MtkFMRadio

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.gatekeeper@1.0-impl:64

# Gnss
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0.vendor:64 \
    android.hardware.gnss@1.1.vendor:64 \
    android.hardware.gnss@2.0.vendor:64 \
    android.hardware.gnss@2.1.vendor:64 \
    android.hardware.gnss.measurement_corrections@1.0.vendor:64 \
    android.hardware.gnss.measurement_corrections@1.1.vendor:64 \
    android.hardware.gnss.visibility_control@1.0.vendor:64 \
	android.hardware.gnss-V1-ndk.vendor:64

# Health
PRODUCT_PACKAGES += \
   android.hardware.health@2.1-service \
   android.hardware.health@2.1-impl

# IR
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-service \
    android.hardware.ir@1.0-impl:64

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0.vendor:64 \
    android.hardware.keymaster@4.0.vendor:64 \
    android.hardware.keymaster@4.1.vendor:64 \
    libkeymaster4.vendor:64 \
    libkeymaster41.vendor:64 \
    libkeymaster4_1support.vendor:64 \
    libkeymaster4support.vendor:64 \
    libkeymaster_messages.vendor:64 \
    libkeymaster_portable.vendor:64 \
    libpuresoftkeymasterdevice.vendor:64

# Light
PRODUCT_PACKAGES += \
    android.hardware.light-service.xiaomi

# Media
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0.vendor \
    android.hardware.media.c2@1.1.vendor \
    android.hardware.media.c2@1.2.vendor \
    libeffects \
    libeffectsconfig.vendor \
    libstagefright_amrnb_common.vendor \
    libstagefright_bufferpool@2.0.1.vendor \
    libstagefright_enc_common.vendor \
    libstagefright_flacdec.vendor \
	libcodec2_hidl@1.0.vendor \
	libcodec2_hidl@1.1.vendor \
	libcodec2_hidl@1.2.vendor \
    libcodec2_soft_common.vendor \
    libstagefright_foundation.vendor

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-service \
    android.hardware.memtrack@1.0-impl:64

# Neural networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.0.vendor \
    android.hardware.neuralnetworks@1.1.vendor \
    android.hardware.neuralnetworks@1.2.vendor \
    android.hardware.neuralnetworks@1.3.vendor

# NFC
PRODUCT_PACKAGES += \
    NfcNci \
    Tag \
    android.hardware.nfc@1.2-service.pn8x \
    com.android.nfc_extras

# NFC/SE configs
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/configs/nfc/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(file))) )

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0.vendor \
    android.hardware.power@1.1.vendor \
    android.hardware.power@1.2.vendor \
	android.hardware.power-V2-ndk.vendor:64

# Radio
PRODUCT_PACKAGES += \
    android.hardware.radio@1.0.vendor \
    android.hardware.radio@1.1.vendor \
    android.hardware.radio@1.2.vendor \
    android.hardware.radio@1.3.vendor \
    android.hardware.radio@1.4.vendor \
    android.hardware.radio@1.5.vendor \
    android.hardware.radio@1.6.vendor \
    android.hardware.radio.config@1.0.vendor \
    android.hardware.radio.config@1.1.vendor \
    android.hardware.radio.config@1.2.vendor \
    android.hardware.radio.config@1.3.vendor

# Renderscript
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# Secure element
PRODUCT_PACKAGES += \
	android.hardware.secure_element@1.0.vendor:64 \
	android.hardware.secure_element@1.1.vendor:64 \
	android.hardware.secure_element@1.2.vendor:64

# Sensors
PRODUCT_PACKAGES += \
    android.frameworks.sensorservice@1.0.vendor \
    android.hardware.sensors-service.multihal \
    libsensorndkbridge

# Sensors MultiHAL config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# SoundTrigger
PRODUCT_PACKAGES += \
    android.hardware.soundtrigger@2.3-impl

# TetherOffload
PRODUCT_PACKAGES += \
    android.hardware.tetheroffload.config@1.0.vendor \
    android.hardware.tetheroffload.control@1.0.vendor \
    android.hardware.tetheroffload.control@1.1.vendor

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0.vendor \
    android.hardware.thermal@2.0.vendor

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0.vendor \
    android.hardware.usb@1.1.vendor \
    android.hardware.usb@1.2.vendor \
    android.hardware.usb@1.3.vendor \
    android.hardware.usb.gadget@1.0.vendor \
    android.hardware.usb.gadget@1.1.vendor

# Vibrator
PRODUCT_PACKAGES += \
	android.hardware.vibrator.service.mt6781

# Wifi
PRODUCT_PACKAGES += \
    libkeystore-wifi-hidl \
    libkeystore-engine-wifi-hidl \
    android.hardware.wifi@1.0-service-lazy.viva \
    wpa_supplicant \
    hostapd

# Wifi configs
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/configs/wifi/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/wifi/, $(notdir $(file))) )

# Other common
PRODUCT_PACKAGES += \
    libtextclassifier_hash.vendor \
    libruy.vendor \
	libmemunreachable \
	libmemunreachable.vendor \
	libflatbuffers-cpp.vendor

# Device overlays
PRODUCT_PACKAGES += \
    FrameworksResOverlayViva \
	SettingsResOverlayViva \
    SystemUIOverlayViva \
    TelephonyOverlayViva \
	CarrierConfigOverlayViva \
	TetheringOverlayViva

# FSTab
PRODUCT_PACKAGES += \
    fstab.mt6781 \
	fstab.mt6781_ramdisk

# Init
PRODUCT_PACKAGES += \
    init.cgroup.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init.modem.rc \
    init.mt6781.rc \
    init.mt6781.usb.rc \
    init.project.rc \
    init.sensor_1_0.rc \
    init_connectivity.rc \
    ueventd.mt6781.rc

# Seccomp
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/configs/seccomp/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/, $(notdir $(file))) )

# Power/Perf configs
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/configs/perf/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(file))) )

# Input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/input/uinput-fpc.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-fpc.kl \
    $(LOCAL_PATH)/configs/input/uinput-goodix.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-goodix.kl \
    $(LOCAL_PATH)/configs/input/excluded-input-devices.xml:$(TARGET_COPY_OUT_VENDOR)/etc/excluded-input-devices.xml

# Public libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/misc/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Kernel prebuilt modules
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(KERNEL_PATH)/modules/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/lib/modules/, $(notdir $(file))) )

# Touchscreen firmware (for recovery)
PRODUCT_COPY_FILES += \
    $(VENDOR_PATH)/vendor/firmware/goodix_firmware.bin:recovery/root/vendor/firmware/goodix_firmware.bin \
    $(VENDOR_PATH)/vendor/firmware/goodix_cfg_group.bin:recovery/root/vendor/firmware/goodix_cfg_group.bin

# IMS
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common

PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH) \
	hardware/xiaomi \
    vendor/nxp/nfc

# Add vendor log tags
include $(LOCAL_PATH)/configs/props/vendor_log_tags.mk

# Inherit our proprietary vendor
$(call inherit-product, vendor/xiaomi/viva/viva-vendor.mk)
