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

$(call inherit-product, device/common/gps/gps_eu.mk)

DEVICE_PACKAGE_OVERLAYS := device/geeksphone/one/overlay
PRODUCT_BRAND := Geeksphone

$(call inherit-product, build/target/product/small_base.mk)

PRODUCT_PACKAGES += \
    Gallery

# This is the list of libraries to include in the build
PRODUCT_PACKAGES += \
    sensors.adq \
    lights.adq \
    copybit.adq \
    gralloc.adq \
    gps.adq \
    libcamera \
    libRS \
    librs_jni \
    hwprops \
    libOmxCore

TINY_TOOLBOX:=true

# We want Russian on top of small_languages
PRODUCT_LOCALES += ru_RU
PRODUCT_DEFAULT_LANGUAGE := en_GB

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
	device/geeksphone/one/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
	device/geeksphone/one/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	device/geeksphone/one/hostapd.conf:system/etc/wifi/hostapd.conf \
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
	vendor/geeksphone/one/proprietary/hostapd:system/bin/hostapd \
	vendor/geeksphone/one/proprietary/libgps.so:obj/lib/libgps.so \
	vendor/geeksphone/one/proprietary/libgps.so:system/lib/libgps.so \
	vendor/geeksphone/one/proprietary/hci_qcomm_init:system/bin/hci_qcomm_init

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := one
PRODUCT_DEVICE := one
PRODUCT_MODEL := Geeksphone ONE
