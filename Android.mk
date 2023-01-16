#
# Copyright (C) 2022 ArrowOS
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(TARGET_DEVICE),viva)
include $(call all-makefiles-under,$(call my-dir))
include $(CLEAR_VARS)

VENDOR_LIB_LINKS := \
	$(TARGET_OUT_VENDOR)/lib/libdpframework.so \
	$(TARGET_OUT_VENDOR)/lib64/libdpframework.so \
	$(TARGET_OUT_VENDOR)/lib/libmtk_drvb.so \
	$(TARGET_OUT_VENDOR)/lib64/libmtk_drvb.so \
	$(TARGET_OUT_VENDOR)/lib/libnir_neon_driver.so \
	$(TARGET_OUT_VENDOR)/lib64/libnir_neon_driver.so \
	$(TARGET_OUT_VENDOR)/lib/libpq_prot.so \
	$(TARGET_OUT_VENDOR)/lib64/libpq_prot.so

GATEKEEPER_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.default.so \
	$(TARGET_OUT_VENDOR)/lib64/hw/gatekeeper.default.so

VULKAN_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib64/hw/vulkan.$(TARGET_BOARD_PLATFORM).so

$(VENDOR_LIB_LINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $(notdir $@)"
	@ln -sf $(TARGET_BOARD_PLATFORM)/$(notdir $@) $@

$(GATEKEEPER_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf libSoftGatekeeper.so $@

$(VULKAN_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking vulkan libs"
	@ln -sf /vendor/lib/egl/libGLES_mali.so $(TARGET_OUT_VENDOR)/lib/hw/vulkan.$(TARGET_BOARD_PLATFORM).so
	@ln -sf /vendor/lib64/egl/libGLES_mali.so $(TARGET_OUT_VENDOR)/lib64/hw/vulkan.$(TARGET_BOARD_PLATFORM).so

ALL_DEFAULT_INSTALLED_MODULES += $(VENDOR_LIB_LINKS) $(GATEKEEPER_SYMLINKS) $(VULKAN_SYMLINKS)

endif
