LOCAL_PATH := $(call my-dir)


## Compile Linux Kernel if available
#KERNEL_DEFCONFIG := adq_defconfig

## Comment this line to use a prebuilt binary
#include kernel/AndroidKernel.mk

## Use prebuilt if kernel source is unavailable
#ifeq ($(TARGET_PREBUILT_KERNEL),)
	TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/prebuilt/adq-kernel
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
$(file) : vendor/geeksphone/one/proprietary/libril-qc-1.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/liboem_rapi.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/liboem_rapi.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/liboncrpc.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/liboncrpc.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libmmgsdilib.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libmmgsdilib.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libgsdi_exp.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libgsdi_exp.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libgstk_exp.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libgstk_exp.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libwms.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libwms.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libnv.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libnv.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libwmsts.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libwmsts.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libdss.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libdss.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libqmi.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libqmi.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libsnd.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libsnd.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libdsm.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libdsm.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libqueue.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libqueue.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libcm.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libcm.so | $(ACP)
	$(transform-prebuilt-to-target)

## End of RIL

## camera and openmax
file := $(TARGET_OUT)/lib/libmm-adspsvc.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libmm-adspsvc.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libmmcamera.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libmmcamera.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libmmcamera_target.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libmmcamera_target.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libmmjpeg.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libmmjpeg.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libOmxH264Dec.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libOmxH264Dec.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libOmxMpeg4Dec.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libOmxMpeg4Dec.so | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT)/lib/libOmxVidEnc.so
ALL_PREBUILT += $(file)
$(file) : vendor/geeksphone/one/proprietary/libOmxVidEnc.so | $(ACP)
	$(transform-prebuilt-to-target)

## End of camera and openmax

## Binary keychar maps

file := $(TARGET_OUT_KEYCHARS)/stmpe1601.kcm.bin
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/stmpe1601.kcm.bin | $(ACP)
	$(transform-prebuilt-to-target)

# init files for boot.img
#
file := $(TARGET_ROOT_OUT)/init.qcom.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.qcom.rc | $(ACP)
	$(transform-prebuilt-to-target)


