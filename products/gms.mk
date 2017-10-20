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
    ro.control_privapp_permissions=enforce \
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
    $(VENDOR_SONYAOSP_PATH)/overlay/common

# Audio (Notifications/Alarms)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Tethys.ogg \
    ro.config.alarm_alert=Oxygen.ogg

# libfuse
PRODUCT_PACKAGES += \
    libfuse

# exfat
PRODUCT_PACKAGES += \
    fsck.exfat \
    libexfat \
    mkfs.exfat \
    mount.exfat

# Audio (Ringtones - Not windy devices allowed)
ifneq ($(filter-out aosp_sgp511 aosp_sgp611 aosp_sgp712, $(TARGET_PRODUCT)),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Titania.ogg
endif

# bootanimation (720p)
ifneq ($(filter aosp_e23% aosp_f5321 aosp_g8441, $(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    $(VENDOR_SONYAOSP_PATH)/prebuilt/common/bootanimation/720p/bootanimation.zip:system/media/bootanimation.zip
endif

# bootanimation (1080p)
ifneq ($(filter aosp_f512% aosp_f813% aosp_f833% aosp_g823% aosp_g814% aosp_g834%, $(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    $(VENDOR_SONYAOSP_PATH)/prebuilt/common/bootanimation/1080p/bootanimation.zip:system/media/bootanimation.zip
endif

# 4K prop for YouTube
## Only for Satsuki and Maple
ifneq ($(filter aosp_e68% aosp_g81%, $(TARGET_PRODUCT)),)
PRODUCT_PROPERTY_OVERRIDES += \
    sys.display-size=3840x2160
endif

# OpenGapps
GAPPS_VARIANT := mini
GAPPS_FORCE_PACKAGE_OVERRIDES := true
GAPPS_FORCE_WEBVIEW_OVERRIDES := true
GAPPS_FORCE_BROWSER_OVERRIDES := true
GAPPS_FORCE_PIXEL_LAUNCHER := true

# Google Assistant
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opa.eligible_device=true

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
    GoogleCamera \
    GoogleContacts \
    GoogleExtServices \
    GoogleExtShared \
    GooglePrintRecommendationService \
    LatinImeGoogle \
    Music2 \
    TagGoogle

$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)
