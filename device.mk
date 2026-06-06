# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

LOCAL_PATH := device/arbor/GT78_VN
# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0.recovery \
    bootctrl.mt6785 \
    bootctrl.mt6785.recovery 

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.mt6785 \
    libgptutils \
    libz \
    libcutils

PRODUCT_PACKAGES += \
    bootctrl
