GO_EASY_ON_ME = 1

ARCHS = armv7 arm64
TARGET = iphone:clang:latest:8.0

include theos/makefiles/common.mk

BUNDLE_NAME = FastFreezeSettings
FastFreezeSettings_FILES = FastFreezeSettings.mm
FastFreezeSettings_CFLAGS = -fobjc-arc
FastFreezeSettings_FRAMEWORKS = UIKit Social
FastFreezeSettings_PRIVATE_FRAMEWORKS = Preferences
FastFreezeSettings_INSTALL_PATH = /Library/PreferenceBundles

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FastFreezeSettings.plist$(ECHO_END)
