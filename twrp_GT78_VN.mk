#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
# SPDX-License-Identifier: Apache-2.0
#

# 继承 TWRP 12.1 官方核心配置
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# 继承设备专有配置 (注意这里改成了 GT78_VN)
$(call inherit-product, device/arbor/GT78_VN/device.mk)

PRODUCT_DEVICE := GT78_VN
PRODUCT_NAME := twrp_GT78_VN
PRODUCT_BRAND := ARBOR
PRODUCT_MODEL := GT78-VN
PRODUCT_MANUFACTURER := arbor

PRODUCT_GMS_CLIENTID_BASE := android-arbor

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_k85v1_64-user 11 RP1A.200720.011 mp1V95182 release-keys"

BUILD_FINGERPRINT := ARBOR/GT78-VN/GT78-VN:11/RP1A.200720.011/mp1V95182:user/release-keys
