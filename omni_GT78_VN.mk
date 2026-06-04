#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from GT78-VN device
$(call inherit-product, device/arbor/GT78-VN/device.mk)

PRODUCT_DEVICE := GT78-VN
PRODUCT_NAME := omni_GT78_VN
PRODUCT_BRAND := ARBOR
PRODUCT_MODEL := GT78-VN
PRODUCT_MANUFACTURER := arbor

PRODUCT_GMS_CLIENTID_BASE := android-arbor

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_k85v1_64-user 11 RP1A.200720.011 mp1V95182 release-keys"

BUILD_FINGERPRINT := ARBOR/GT78-VN/GT78-VN:11/RP1A.200720.011/mp1V95182:user/release-keys
