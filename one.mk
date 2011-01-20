#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/common/gps/gps_eu.mk)

DEVICE_PACKAGE_OVERLAYS := device/geeksphone/one/overlay
PRODUCT_BRAND := Geeksphone

$(call inherit-product, $(SRC_TARGET_DIR)/product/core.mk)

## Overload the default package list, cut down on non-necessary stuff to
## save space. Update from full.mk on new versions!
PRODUCT_PACKAGES += \
    AccountAndSyncSettings \
    DeskClock \
    AlarmProvider \
    Bluetooth \
    Calculator \
    Calendar \
    Camera \
    CertInstaller \
    DrmProvider \
    Email \
    Gallery \
    LatinIME \
    Launcher2 \
    Mms \
    Music \
    Provision \
    Protips \
    QuickSearchBox \
    Settings \
    Superuser \
    Sync \
    SystemUI \
    Updater \
    CalendarProvider \
    SyncProvider


# This is the list of apps to include in the build
PRODUCT_PACKAGES += \
	TSCalibration

# This is the list of libraries to include in the build
PRODUCT_PACKAGES += \
    sensors.adq \
    lights.adq \
    copybit.adq \
    gralloc.adq \
    gps.adq \
    libril.adq \
    libaudio \
    libaudiopolicy \
    libcamera \
    libRS \
    librs_jni \
    hwprops \
    libOmxCore

TINY_TOOLBOX:=true

# This is the list of locales included in AOSP builds
PRODUCT_LOCALES := mdpi ru_RU
PRODUCT_DEFAULT_LANGUAGE := en_GB

$(call inherit-product, build/target/product/languages_small.mk)

# Enable RingerSwitch
PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.ringerswitch=1

# The user-visible product name
PRODUCT_MODEL := Geeksphone ONE

PRODUCT_PROPERTY_OVERRIDES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-fih \
    ro.com.google.clientidbase.yt=android-fih \
    ro.com.google.clientidbase.am=android-fih \
    ro.com.google.clientidbase.vs=android-fih \
    ro.com.google.clientidbase.gmm=android-fih \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.mode=OPTIONAL \
    keyguard.no_require_sim=true \
    ro.com.android.dateformat=dd-MM-yyyy \
    ro.com.android.dataroaming=true 


# Configuration
#
PRODUCT_COPY_FILES += \
	device/geeksphone/one/prebuilt/libril.so:system/lib/libril.so \
	device/geeksphone/one/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
	device/geeksphone/one/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/geeksphone/one/ueventd.qcom.rc:root/ueventd.qct.rc \
	device/geeksphone/one/init.qcom.bt.sh:system/etc/init.qcom.bt.sh \
	device/geeksphone/one/vold.fstab:system/etc/vold.fstab \
	frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml


## Libraries and proprietary binaries
PRODUCT_COPY_FILES += \
	vendor/geeksphone/one/proprietary/data.patch.hw2_0.bin:system/etc/wifi/fw/data.patch.hw2_0.bin \
	vendor/geeksphone/one/proprietary/eeprom.bin:system/etc/wifi/fw/eeprom.bin \
	vendor/geeksphone/one/proprietary/athwlan.bin.z77:system/etc/wifi/fw/athwlan.bin.z77 \
	vendor/geeksphone/one/proprietary/libgps.so:obj/lib/libgps.so \
	vendor/geeksphone/one/proprietary/libgps.so:system/lib/libgps.so \
	vendor/geeksphone/one/proprietary/hci_qcomm_init:system/bin/hci_qcomm_init


PRODUCT_NAME := geeksphone_one

