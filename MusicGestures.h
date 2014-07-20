/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import <UIKit/UIKit.h>

typedef enum {
  MGSwipeNone  = 0,
  MGSwipeUp    = 1,
  MGSwipeDown  = 2,
  MGSwipeLeft  = 3,
  MGSwipeRight = 4,
} MGSwipe;

typedef enum {
  MGTapNone   = 0,
  MGTapSingle = 1,
  MGTapDouble = 2,
  MGTapTriple = 3,
} MGTap;

typedef enum {
  MGShuffleTypeOff    = 0,
  MGShuffleTypeSongs  = 1,
  MGShuffleTypeAlbums = 2,
} MGShuffleType;

typedef enum {
  MGActionNone               = 0,
  MGActionPrevTrack          = 1,
  MGActionNextTrack          = 2,
  MGActionTogglePlayback     = 3,
  MGActionShowFlipside       = 4,
  MGActionExitNowPlaying     = 5, // < iOS 7
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

extern NSString* const kGestureBackSwipeUp;
extern NSString* const kGestureBackSwipeDown;
extern NSString* const kGestureBackSwipeLeft;
extern NSString* const kGestureBackSwipeRight;

extern NSString* const kGestureBackTapSingle;
extern NSString* const kGestureBackTapDouble;
extern NSString* const kGestureBackTapTriple;

extern NSString* const kGestureBackPinch;

extern NSMutableDictionary* preferencesDict;
