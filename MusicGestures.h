/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

typedef enum {
  MGActionNone               = 0,
  MGActionPrevTrack          = 1,
  MGActionNextTrack          = 2,
  MGActionTogglePlayback     = 3,
  MGActionShowFlipside       = 4,
  MGActionExitNowPlaying     = 5, // Unused
  MGActionShowLyricsOrRating = 6,
  MGActionAdjustVolume       = 7, // Unused
  MGActionSeekBackward       = 8,
  MGActionSeekForward        = 9,
  MGActionSkipBackward       = 10,
  MGActionSkipForward        = 11,
} MGAction;

extern NSString* const kGestureFrontSwipeUp;
extern NSString* const kGestureFrontSwipeDown;
extern NSString* const kGestureFrontSwipeLeft;
extern NSString* const kGestureFrontSwipeRight;

extern NSString* const kGestureFrontTapSingle;
extern NSString* const kGestureFrontTapDouble;
extern NSString* const kGestureFrontTapTriple;

extern NSString* const kGestureFrontPinch;

extern NSString* const kGestureFrontLongPress;

extern NSString* const kFrontSkipLength;

extern NSMutableDictionary* preferencesDict;
