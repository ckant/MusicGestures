
GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = MusicGestures
MusicGestures_FILES = Tweak.xm
MusicGestures_FRAMEWORKS = MediaPlayer
MusicGestures_PRIVATE_FRAMEWORKS = iPodUI

include $(THEOS_MAKE_PATH)/tweak.mk
