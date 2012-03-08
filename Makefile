
GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = MusicGestures
MusicGestures_FILES = Tweak.xm \
                      MPSwipableView.m \
                      MPViewController.m \
                      IUNowPlayingFrontViewController.m \
                      IUNowPlayingBackViewController.m
MusicGestures_FRAMEWORKS = MediaPlayer UIKit
MusicGestures_PRIVATE_FRAMEWORKS = iPodUI

include $(THEOS_MAKE_PATH)/tweak.mk
