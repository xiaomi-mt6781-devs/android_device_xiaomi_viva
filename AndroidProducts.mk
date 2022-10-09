#
# Copyright (C) 2022 ArrowOS
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
	$(LOCAL_DIR)/arrow_viva.mk

COMMON_LUNCH_CHOICES := \
	$(foreach FLAVOR, user userdebug eng, arrow_viva-$(FLAVOR))

