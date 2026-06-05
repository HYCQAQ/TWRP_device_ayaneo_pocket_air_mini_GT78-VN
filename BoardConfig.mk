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

# 主架构 (保持不变)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

# 副架构 (修改为符合 Android 12 规范的定义)
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

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
# BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
# BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

BOARD_KERNEL_IMAGE_NAME := Image

# Kernel - 预编译内核与 DTB
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_KERNEL_IMAGE_NAME := Image

# 直接让 mkbootimg 去你设备树的原路径下吃 dtb 文件
BOARD_MKBOOTIMG_ARGS += --dtb $(DEVICE_PATH)/prebuilt/dtb.img

# Partitions 分区大小（请务必确认 33554432 是否与你提取的官方 boot.img 大小一致）
BOARD_FLASH_BLOCK_SIZE := 131072 
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
# 必须为 metadata 分区分配空间，否则挂载会失败
BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
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
PLATFORM_SECURITY_PATCH := 2022-09-01
VENDOR_SECURITY_PATCH := 2022-09-01

# Verified Boot (AVB 校验)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# TWRP 界面与显示配置（横屏掌机模式）
TW_THEME := landscape_hdpi
RECOVERY_VARIANT := twrp
# 语言包精简：关闭“全语言包”
TW_EXTRA_LANGUAGES := false
TW_DEFAULT_LANGUAGE := zh_CN

TW_SCREEN_BLANK_ON_BOOT := true
# 修复：精准屏蔽内置的 Xbox360 手柄事件流，让 hyn_ts 触屏恢复正常
TW_INPUT_BLACKLIST := "hbtp_vm X-box Microsoft pad"
TW_USE_TOOLBOX := true
# 精简空间关闭重打包工具
TW_INCLUDE_REPACKTOOLS := false
TW_SCREEN_RES_X := 1280
TW_SCREEN_RES_Y := 960


# ADB 调试配置
TW_ADB_ENABLE_IN_STARTUP := true
# 精简空间关闭调试工具
TWRP_INCLUDE_LOGCAT := true
TW_USE_NEW_MINADBD := true

# MTK 硬件适配与背光
BOARD_HAS_MTK_HARDWARE := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"

# 修复：完善安卓 11/12 FBE 解密必需参数
TW_INCLUDE_CRYPTO := true
# 强制 TWRP 适应 Android 11 的 FBE 加密密钥处理
TW_INCLUDE_CRYPTO_FBE := true
TW_CRYPTO_USE_SYSTEM_VOLD := true
BOARD_USES_METADATA_PARTITION := true

# 其他功能
TW_HAS_DOWNLOAD_MODE := true

# 注入 Android 11+ A/B 槽位切换服务
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0-service.recovery

# 兼容性代号
TARGET_RECOVERY_DEVICE_ALIASES := GT78-VN

# ====== TWRP 镜像瘦身优化 (修正编译冲突版) ======
# 只通过 BOARD_DO_NOT_STRIP_RECOVERY 控制是否剥离调试符号
BOARD_DO_NOT_STRIP_RECOVERY := false

# 使用更通用的压缩配置
LZMA_RAMDISK_TARGET_COMPRESSION := true

