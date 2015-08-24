THEOS_DEVICE_IP = 127.0.0.1
THEOS_DEVICE_PORT = 2222
THEOS_PACKAGE_DIR_NAME = deb

GO_EASY_ON_ME = 1

ARCHS = armv7 arm64
TARGET = iphone:clang:latest:8.0

include theos/makefiles/common.mk

TWEAK_NAME = FastFreeze
FastFreeze_FILES = Tweak.xm
FastFreeze_CFLAGS = -fobjc-arc
FastFreeze_LIBRARIES = substrate
FastFreeze_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += FastFreezeSettings

include $(THEOS_MAKE_PATH)/aggregate.mk

before-stage::
	find . -name ".DS_Store" -delete
after-install::
	install.exec "killall -9 backboardd"
