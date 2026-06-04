#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
# SPDX-License-Identifier: Apache-2.0
#

# 路径需与你在线编译器填写的 DEVICE_PATH 严格一致
DEVICE_PATH := device/arbor/GT78_VN

# 允许最小清单缺少非必要依赖
ALLOW_MISSING_DEPENDENCIES := true

# A/B 虚拟分区配置
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    product \
    vendor \
    vbmeta_system \
    vbmeta_vendor \
    boot \
    system

# 没有独立 recovery 分区，Recovery 包含在 boot 中
BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture 架构参数 (MT6785)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := k85v1_64
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 320

# Kernel 核心打包参数优化
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user

# 修复：必须明确将 base 和 pagesize 压入打包参数
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_CONFIG := _defconfig
TARGET_KERNEL_SOURCE := kernel/arbor/GT78-VN

# Kernel - 使用预编译内核
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
endif

# Partitions 分区大小（请务必确认 33554432 是否与你提取的官方 boot.img 大小一致）
BOARD_FLASH_BLOCK_SIZE := 131072 
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := arbor_dynamic_partitions
BOARD_ARBOR_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_ARBOR_DYNAMIC_PARTITIONS_SIZE := 9122611200

# Platform
TARGET_BOARD_PLATFORM := mt6785

# Recovery
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# 修复：版本号改为 12 以匹配 TWRP 12.1 分支
PLATFORM_VERSION := 12

# 修复：安全补丁日期【必须】改成你掌机当前官方系统的真实日期，否则无法解密 DATA
# 举例：如果是 2021年8月1日，请保持下方不变。如果是其他日期请手动替换。
PLATFORM_SECURITY_PATCH := 2022-09-01
VENDOR_SECURITY_PATCH := 2022-09-01

# Verified Boot (AVB 校验)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# TWRP 界面与显示配置（横屏掌机模式）
TW_THEME := landscape_hdpi
RECOVERY_VARIANT := twrp
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_SCREEN_RES_X := 1280
TW_SCREEN_RES_Y := 960
TW_DEFAULT_LANGUAGE := zh_CN

# ADB 调试配置
TW_ADB_ENABLE_IN_STARTUP := true
TWRP_INCLUDE_LOGCAT := true
TW_USE_NEW_MINADBD := true

# MTK 硬件适配与背光
BOARD_HAS_MTK_HARDWARE := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"

# 修复：完善安卓 11/12 FBE 解密必需参数
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_METADATA_PARTITION := true

# 其他功能
TW_HAS_DOWNLOAD_MODE := true

# 注入 Android 11+ A/B 槽位切换服务
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0-service.recovery
