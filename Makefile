include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Chrysalis
Chrysalis_FILES = Tweak.xm $(wildcard *.x) $(wildcard *.m)

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Preferences"
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
