LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE), GT78_VN)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
