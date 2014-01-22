
TARGET=:clang
ARCHS = armv7 armv7s arm64

all::
	logos/logos_preprocess.sh

GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = MusicGestures
MusicGestures_FILES = logos/out/Tweak.xm
MusicGestures_FRAMEWORKS = UIKit 

CFLAGS = -I. -v

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += PreferenceBundle
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 Music; killall -9 Music~iphone; killall -9 Preferences; true"
