
GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = MusicGestures
MusicGestures_FILES = Tweak.xm \
                      MusicNowPlayingViewController+MusicGestures.m
MusicGestures_FRAMEWORKS = UIKit MediaPlayer 
MusicGestures_PRIVATE_FRAMEWORKS = MusicUI

include $(THEOS_MAKE_PATH)/tweak.mk
