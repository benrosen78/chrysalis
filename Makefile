include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Chrysalis
Chrysalis_FILES = Tweak.xm $(wildcard *.x) $(wildcard *.m)
Chrysalis_EXTRA_FRAMEWORKS = Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
