#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/mumba

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := parrot

# Display
TARGET_SCREEN_DENSITY := 390

# DTB / DTBO
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_USES_QCOM_MERGE_DTBS_SCRIPT := true
TARGET_NEEDS_DTBOIMAGE := true
TARGET_MERGE_DTBS_WILDCARD ?= parrot-moto-base-nfc*
TARGET_MERGE_DTBOS_WILDCARD ?= parrot-mumba*

# Init Boot
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

# Boot
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# Kernel
BOARD_KERNEL_CMDLINE += \
    console=ttyMSM0,115200n8 \
    audit_backlog_limit=4096 \
    nosoftlockup \
    printk.devkmsg=on \
    firmware_class.path=/vendor/firmware_mnt/image \
    qcom_geni_serial.con_enabled=0 \
    sysctl.kernel.firmware_config.force_sysfs_fallback=1

BOARD_BOOTCONFIG += \
    androidboot.hardware=qcom \
    androidboot.load_modules_parallel=true \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.hypervisor.protected_vm.supported=true \
    androidboot.vendor.qspa=true

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000
BOARD_RAMDISK_USE_LZ4 := true

TARGET_KERNEL_SOURCE := kernel/motorola/sm6435
TARGET_KERNEL_VERSION := 6.6

TARGET_KERNEL_CONFIG := \
    gki_defconfig \
    vendor/parrot_perf.config \
    vendor/ext_config/moto-parrot.config \
    vendor/ext_config/moto-parrot-mumba.config

# Kernel modules
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules/modules.blocklist.vendor_dlkm
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.vendor_dlkm))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules/modules.blocklist.vendor_boot
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.vendor_boot $(DEVICE_PATH)/modules.load.recovery))
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.system_dlkm))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)
SYSTEM_KERNEL_MODULES := $(BOARD_SYSTEM_KERNEL_MODULES_LOAD)

TARGET_KERNEL_EXT_MODULE_ROOT := kernel/motorola/sm6435-modules
TARGET_KERNEL_EXT_MODULES := \
    qcom/opensource/mmrm-driver \
    qcom/opensource/mm-drivers/msm_ext_display \
    qcom/opensource/mm-drivers/sync_fence \
    qcom/opensource/audio-kernel \
    qcom/opensource/securemsm-kernel \
    qcom/opensource/synx-kernel \
    qcom/opensource/camera-kernel \
    qcom/opensource/data-kernel/drivers/smem-mailbox \
    qcom/opensource/datarmnet-ext/mem \
    qcom/opensource/dataipa/drivers/platform/msm \
    qcom/opensource/datarmnet/core \
    qcom/opensource/datarmnet-ext/aps \
    qcom/opensource/datarmnet-ext/offload \
    qcom/opensource/datarmnet-ext/perf \
    qcom/opensource/datarmnet-ext/perf_tether \
    qcom/opensource/datarmnet-ext/sch \
    qcom/opensource/datarmnet-ext/shs \
    qcom/opensource/datarmnet-ext/wlan \
    qcom/opensource/display-drivers/msm \
    qcom/opensource/dsp-kernel \
    qcom/opensource/graphics-kernel \
    qcom/opensource/video-driver \
    qcom/opensource/wlan/platform \
    qcom/opensource/wlan/qcacld-3.0/.adrastea \
    qcom/opensource/bt-kernel \
    nxp/opensource/driver \
    st/opensource/driver \

TARGET_KERNEL_EXT_MODULES += \
    motorola/drivers/mmi_annotate \
    motorola/drivers/mmi_info \
    motorola/drivers/moto_swap \
    motorola/drivers/moto_reboot_reason \
    motorola/drivers/moto_f_usbnet \
    motorola/drivers/mmi_relay \
    motorola/drivers/moto_mmap_fault \
    motorola/drivers/moto_netopt/con_dfpar \
    motorola/drivers/moto_binder \
    motorola/drivers/power/mmi_charger \
    motorola/drivers/misc/mmi_stow \
    motorola/drivers/moto_mm \
    motorola/drivers/moto_sched \
    motorola/drivers/watchdogtest \
    motorola/drivers/sensors \
    motorola/drivers/misc/sx937x \
    motorola/drivers/misc/utag \
    motorola/drivers/misc/mmi_sys_temp \
    motorola/drivers/power/qpnp_adaptive_charge \
    motorola/drivers/power/bm_adsp_ulog \
    motorola/drivers/power/qti_glink_charger \
    motorola/drivers/misc/awinic/sarsensor \
    motorola/drivers/fm \
    motorola/drivers/backlight/ktd3136 \
    motorola/drivers/backlight/aw99703 \
    motorola/drivers/nfc/st21nfc \
    motorola/drivers/ese/st54x \
    motorola/drivers/ese/st54spi_gpio \
    motorola/drivers/input/misc/fpc_fps_mmi \
    motorola/drivers/input/touchscreen/chipone_tddi_v3_mmi \
    motorola/drivers/input/touchscreen/ilitek_v4_mmi \
    motorola/drivers/input/misc/anc_fps_mmi \
    motorola/drivers/wlan_antenna

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
-include vendor/lineage/config/BoardConfigReservedSize.mk
BOARD_BUILD_VENDOR_RAMDISK_IMAGE := true

BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 32)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_PVMFWIMAGE_PARTITION_SIZE := 2097152

BOARD_SUPER_PARTITION_SIZE := 8589934592
BOARD_SUPER_PARTITION_GROUPS := mot_dp_group
BOARD_MOT_DP_GROUP_SIZE := 8585740288 # (BOARD_SUPER_PARTITION_SIZE - 4MB)
BOARD_MOT_DP_GROUP_PARTITION_LIST := product system system_dlkm system_ext vendor vendor_dlkm

$(foreach p, $(call to-upper, $(BOARD_MOT_DP_GROUP_PARTITION_LIST)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := parrot

# Recovery
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# SEPolicy
include device/qcom/sepolicy_vndr/SEPolicy.mk
include hardware/motorola/sepolicy/qti/SEPolicy.mk

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_ROLLBACK_INDEX := 22
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 22
BOARD_AVB_VBMETA_SYSTEM := system system_ext product pvmfw
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# Include the proprietary files BoardConfig.
include vendor/motorola/mumba/BoardConfigVendor.mk
