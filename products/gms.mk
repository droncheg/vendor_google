# Copyright (C) 2016 The Sony AOSP Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# vendor path
VENDOR_SONYAOSP_PATH := vendor/google

# Google property overides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true

# SELinux
BOARD_USE_ENFORCING_SELINUX := true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Kernel-headers FLAG
TARGET_COMPILE_WITH_MSM_KERNEL := true

# Include overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/google/overlay/common

# Audio (Notifications/Alarms)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Tethys.ogg \
    ro.config.alarm_alert=Oxygen.ogg

# Audio (Ringtones - Not windy devices allowed)
ifneq ($(filter-out aosp_sgp511 aosp_sgp611 aosp_sgp712, $(TARGET_PRODUCT)),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Titania.ogg
endif

# bootanimation (240-320 DPI)
ifneq ($(filter aosp_sgp521 aosp_sgp511_windy aosp_sgp621 aosp_sgp611_windy aosp_d5803 aosp_e23% aosp_e5823 aosp_d5503 aosp_c6833 aosp_sgp771 aosp_sgp712_windy aosp_f5321, $(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/google/prebuilt/common/bootanimation/240_320/bootanimation.zip:system/media/bootanimation.zip
endif

# bootanimation (480 DPI)
ifneq ($(filter aosp_c6903 aosp_d6503 aosp_d6603 aosp_e65% aosp_e66% aosp_e68% aosp_f512%, $(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/google/prebuilt/common/bootanimation/480/bootanimation.zip:system/media/bootanimation.zip
endif

# RIL
ifneq ($(filter aosp_c6903 aosp_d5503 aosp_c6833, $(TARGET_PRODUCT)),)
BOARD_RIL_CLASS := ../../../$(VENDOR_SONYAOSP_PATH)/ril-rhine/

PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.ril_class=SonyRIL
endif

# OpenGapps
GAPPS_VARIANT := mini
GAPPS_FORCE_PACKAGE_OVERRIDES := true
GAPPS_FORCE_WEBVIEW_OVERRIDES := true
GAPPS_FORCE_BROWSER_OVERRIDES := true
GAPPS_FORCE_PIXEL_LAUNCHER := true

# Telephony Packages (Not windy devices allowed)
ifneq ($(filter-out aosp_sgp511 aosp_sgp611 aosp_sgp712, $(TARGET_PRODUCT)),)
GAPPS_FORCE_DIALER_OVERRIDES := true
GAPPS_FORCE_MMS_OVERRIDES := true

# Audio (Ringtones)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Orion.ogg
endif

# Add some extras not in micro
# To override stock AOSP apps
PRODUCT_PACKAGES += \
    GoogleContacts \
    LatinImeGoogle \
    Music2

# GoogleCamera doesn't support HAL1 on Nougat
# Allow only Tone and Yoshino for now
ifneq ($(filter aosp_f813% aosp_f833% aosp_g823% aosp_g814%, $(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    GoogleCamera
endif

ifneq ($(filter-out aosp_c6903 aosp_c6833 aosp_d5503, $(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    TagGoogle
endif

$(call inherit-product, vendor/google/build/opengapps-packages.mk)
