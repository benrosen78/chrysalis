include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Chrysalis
Chrysalis_FILES = Tweak.xm CSWindow.x CSAppSwitcherViewController.x

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
