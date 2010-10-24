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

# This is the list of apps to include in the build
PRODUCT_PACKAGES := \
	Gallery

# This is the list of libraries to include in the build
PRODUCT_PACKAGES += \
    sensors.adq \
    lights.adq \
    libRS \
    librs_jni

TINY_TOOLBOX:=true

# This is the list of locales included in AOSP builds
PRODUCT_LOCALES := mdpi

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
	ro.com.android.dateformat=dd-MM-yyyy \
	ro.com.android.dataroaming=true 

# Configuration
#
PRODUCT_COPY_FILES += \
	device/geeksphone/one/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
	device/geeksphone/one/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml


## Libraries and proprietary binaries
PRODUCT_COPY_FILES += \
	device/geeksphone/one/proprietary/data.patch.hw2_0.bin:system/etc/wifi/fw/data.patch.hw2_0.bin \
	device/geeksphone/one/proprietary/eeprom.bin:system/etc/wifi/fw/eeprom.bin \
	device/geeksphone/one/proprietary/athwlan.bin.z77:system/etc/wifi/fw/athwlan.bin.z77 \
	device/geeksphone/one/proprietary/libgps.so:obj/lib/libgps.so \
	device/geeksphone/one/proprietary/libgps.so:system/lib/libgps.so \
	device/geeksphone/one/proprietary/hci_qcomm_init:system/bin/hci_qcomm_init


$(call inherit-product, build/target/product/full.mk)
PRODUCT_NAME := geeksphone_one

