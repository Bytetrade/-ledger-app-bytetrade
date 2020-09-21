#*******************************************************************************
#   Ledger Blue
#   (c) 2016 Ledger
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#*******************************************************************************

# TARGET_NAME := TARGET_NANOX

ifeq ($(BOLOS_SDK),)
$(error BOLOS_SDK is not set)
endif
include $(BOLOS_SDK)/Makefile.defines



# U2F
DEFINES   += HAVE_U2F HAVE_IO_U2F
DEFINES   += U2F_PROXY_MAGIC=\"w0w\"
DEFINES   += USB_SEGMENT_SIZE=64
DEFINES   += BLE_SEGMENT_SIZE=32 #max MTU, min 20
DEFINES   += UNUSED\(x\)=\(void\)x
DEFINES   += APPVERSION=\"$(APPVERSION)\"


# Main app configuration

# DEFINES += TARGET_NANOX

DEFINES_LIB = USE_LIB_BYTETRADE
APPNAME = "Byte Trade"
APPVERSION = 1.0.0
APP_LOAD_PARAMS = --appFlags 0x240 $(COMMON_LOAD_PARAMS)
# APP_LOAD_PARAMS=--appFlags 0x250 --dep Bytetrade:$(APPVERSION) $(COMMON_LOAD_PARAMS)

ifeq ($(TARGET_NAME),TARGET_BLUE)
ICONNAME=blue_app_bytetrade.gif
else
	ifeq ($(TARGET_NAME),TARGET_NANOX)
ICONNAME=nanox_app_bytetrade.gif
	else
ICONNAME=nanos_app_bytetrade.gif
	endif
endif

# Message
# DEFINES += UI_SHOW_FEE

DEFINES += UI_SHOW_CREATOR
DEFINES += UI_PROPOSALER
DEFINES += UI_SHOW_PLEDGER
DEFINES += UI_SHOW_SIDE
DEFINES += UI_SHOW_ORDER_TYPE
DEFINES += UI_SHOW_MARKET_NAME
DEFINES += UI_SHOW_AMOUNT
DEFINES += UI_SHOW_PRICE
DEFINES += UI_SHOW_FROM
DEFINES += UI_SHOW_TO
DEFINES += UI_SHOW_MESSAGE

DEFINES += UI_SHOW_TO_EXTERNAL_ADDRESS

# DEFINES += UI_SHOW_USE_BTT_AS_FEE
# DEFINES += UI_SHOW_FREEZE_BTT_FEE
# DEFINES += UI_SHOW_NOW
# DEFINES += UI_SHOW_EXPIRATION
# DEFINES += UI_SHOW_CUSTOM_BTT_FEE_RATE
# DEFINES += UI_SHOW_CUSTOM_NO_BTT_FEE_RATE
# DEFINES += UI_SHOW_MONEY_ID
# DEFINES += UI_SHOW_STOCK_ID
# DEFINES += UI_SHOW_ORDER_ID
# DEFINES += UI_SHOW_ASSET_TYPE
# DEFINES += UI_SHOW_ASSET_FEE
# DEFINES += UI_SHOW_PAYMENT_ID
# DEFINES += UI_SHOW_CONTRACT_ID

# Build configuration

ifeq ($(TARGET_NAME),TARGET_NANOX)
DEFINES   += UI_NANO_X
TARGET_UI := FLOW
else ifeq ($(TARGET_NAME),TARGET_BLUE)
DEFINES   += UI_BLUE
else
DEFINES   += UI_NANO_S
endif

APP_SOURCE_PATH += src 
SDK_SOURCE_PATH += lib_stusb lib_stusb_impl lib_u2f

ifeq ($(TARGET_UI),FLOW)
SDK_SOURCE_PATH  += lib_ux
endif

ifeq ($(TARGET_NAME),TARGET_NANOX)
SDK_SOURCE_PATH  += lib_blewbxx lib_blewbxx_impl
endif

DEFINES += APPVERSION=\"$(APPVERSION)\"

DEFINES += OS_IO_SEPROXYHAL IO_SEPROXYHAL_BUFFER_SIZE_B=128
DEFINES += HAVE_BAGL HAVE_SPRINTF
DEFINES += PRINTF\(...\)=

DEFINES += HAVE_IO_USB HAVE_L4_USBLIB IO_USB_MAX_ENDPOINTS=4 IO_HID_EP_LENGTH=64 HAVE_USB_APDU

DEFINES   += HAVE_WEBUSB WEBUSB_URL_SIZE_B=0 WEBUSB_URL=""

DEFINES += CX_COMPLIANCE_141

# Compiler, assembler, and linker

ifneq ($(BOLOS_ENV),)
$(info BOLOS_ENV=$(BOLOS_ENV))
CLANGPATH := $(BOLOS_ENV)/clang-arm-fropi/bin/
GCCPATH := $(BOLOS_ENV)/gcc-arm-none-eabi-5_3-2016q1/bin/
else
$(info BOLOS_ENV is not set: falling back to CLANGPATH and GCCPATH)
endif

ifeq ($(CLANGPATH),)
$(info CLANGPATH is not set: clang will be used from PATH)
endif

ifeq ($(GCCPATH),)
$(info GCCPATH is not set: arm-none-eabi-* will be used from PATH)
endif

CC := $(CLANGPATH)clang
CFLAGS += -O3 -Os

AS := $(GCCPATH)arm-none-eabi-gcc
AFLAGS +=

LD := $(GCCPATH)arm-none-eabi-gcc
LDFLAGS += -O3 -Os
LDLIBS += -lm -lgcc -lc

# Main rules

all: default

load: all
	python -m ledgerblue.loadApp $(APP_LOAD_PARAMS)

delete:
	python -m ledgerblue.deleteApp $(COMMON_DELETE_PARAMS)

# Import generic rules from the SDK

include $(BOLOS_SDK)/Makefile.rules
