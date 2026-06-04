PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_GT78_VN.mk

COMMON_LUNCH_CHOICES := \
    twrp_GT78_VN-userdebug \
    twrp_GT78_VN-eng

# 必须写在 AndroidBoard.mk 或 Android.mk 中
$(PRODUCT_OUT)/dtb.img: $(LOCAL_PATH)/prebuilt/dtb.img
	@echo "==== 正在强行搬运预编译 DTB 镜像 ===="
	$(hide) mkdir -p $(dir $@)
	$(hide) cp $< $@

.PHONY: $(PRODUCT_OUT)/dtb.img
