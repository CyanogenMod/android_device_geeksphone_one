LOCAL_PATH := $(call my-dir)


## Compile Linux Kernel if available
#KERNEL_DEFCONFIG := adq_defconfig

## Comment this line to use a prebuilt binary
#include kernel/AndroidKernel.mk

## Use prebuilt if kernel source is unavailable
#ifeq ($(TARGET_PREBUILT_KERNEL),)
	TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/adq-kernel
#endif

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file) : $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

## Keyboard maps

file := $(TARGET_OUT_KEYLAYOUT)/stmpe1601.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/stmpe1601.kl | $(ACP)
	$(transform-prebuilt-to-target)

## RIL from cupcake

file := $(TARGET_OUT)/lib/libril-qc-1.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libril-qc-1.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/liboem_rapi.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/liboem_rapi.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/liboncrpc.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/liboncrpc.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libmmgsdilib.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libmmgsdilib.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libgsdi_exp.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libgsdi_exp.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libgstk_exp.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libgstk_exp.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libwms.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libwms.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libnv.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libnv.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libwmsts.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libwmsts.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libdss.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libdss.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libqmi.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libqmi.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libsnd.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libsnd.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libdsm.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libdsm.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libqueue.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libqueue.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libcm.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libcm.so | $(ACP)
	$(transform-prebuilt-to-target)

## End of RIL

## camera and openmax
file := $(TARGET_OUT)/lib/libmm-adspsvc.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libmm-adspsvc.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libmmcamera.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libmmcamera.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libmmcamera_target.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libmmcamera_target.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libmmjpeg.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libmmjpeg.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libOmxH264Dec.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libOmxH264Dec.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libOmxMpeg4Dec.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libOmxMpeg4Dec.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libOmxVidEnc.so
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/proprietary/libOmxVidEnc.so | $(ACP)
	$(transform-prebuilt-to-target)

## End of camera and openmax

## Binary keychar maps

file := $(TARGET_OUT_KEYCHARS)/stmpe1601.kcm.bin
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/stmpe1601.kcm.bin | $(ACP)
	$(transform-prebuilt-to-target)

# init files for boot.img
#
file := $(TARGET_ROOT_OUT)/init.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.one.rc | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.qcom.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.qcom.rc | $(ACP)
	$(transform-prebuilt-to-target)


# This will install the file in /system/etc
#

include $(CLEAR_VARS)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE := vold.fstab
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := init.qcom.bt.sh
LOCAL_MODULE_TAGS := user
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

