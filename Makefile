include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Chrysalis
Chrysalis_FILES = Tweak.xm $(wildcard *.x) $(wildcard *.m)
Chrysalis_PRIVATE_FRAMEWORKS = FrontBoard
Chrysalis_EXTRA_FRAMEWORKS = Cephei
Chrysalis_CFLAGS = -include Global.h

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
ifeq ($(RESPRING),0)
	install.exec "killall Preferences"
else
	install.exec spring
endif

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
