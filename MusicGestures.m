/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "MusicGestures.h"
 
#import "legacy/MPViewController.h"
#import "legacy/MPSwipableView.h"
#import "legacy/IUNowPlayingAlbumFrontViewController.h"
#import "legacy/IUNowPlayingAlbumBackViewController.h"


#define kDefaultsFilename \
  [NSHomeDirectory() stringByAppendingPathComponent:\
  @"Library/Preferences/com.ckant.musicgestures.plist"]

#define kPreferencesUpdated "com.ckant.musicgestures.updatePrefs"

NSMutableDictionary* preferencesDict = nil;

/* Gestures */
NSString* const kGestureFrontSwipeUp    = @"frontSwipeUp";
NSString* const kGestureFrontSwipeDown  = @"frontSwipeDown";
NSString* const kGestureFrontSwipeLeft  = @"frontSwipeLeft";
NSString* const kGestureFrontSwipeRight = @"frontSwipeRight";

NSString* const kGestureFrontTapSingle  = @"frontTapSingle";
NSString* const kGestureFrontTapDouble  = @"frontTapDouble";
NSString* const kGestureFrontTapTriple  = @"frontTapTriple";

NSString* const kGestureFrontPinch      = @"frontPinch";

NSString* const kGestureFrontLongPress  = @"frontLongPress";

NSString* const kGestureBackSwipeUp     = @"backSwipeUp";
NSString* const kGestureBackSwipeDown   = @"backSwipeDown";
NSString* const kGestureBackSwipeLeft   = @"backSwipeLeft";
NSString* const kGestureBackSwipeRight  = @"backSwipeRight";

NSString* const kGestureBackTapSingle   = @"backTapSingle";
NSString* const kGestureBackTapDouble   = @"backTapDouble";
NSString* const kGestureBackTapTriple   = @"backTapTriple";

NSString* const kGestureBackPinch       = @"backPinch";

/* Intervals */
NSString* const kFrontSkipLength        = @"frontSkipLength";

/**
 * Creates a dictionary with defaults
 */
static void initDefaultPreferences() {

  preferencesDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    
    /* Front defaults */
    [NSString stringWithFormat:@"%d", MGActionNextTrack], kGestureFrontSwipeLeft,
    [NSString stringWithFormat:@"%d", MGActionPrevTrack], kGestureFrontSwipeRight,
    [NSString stringWithFormat:@"%d", MGActionShowLyricsOrRating], kGestureFrontTapSingle,
    [NSString stringWithFormat:@"%d", MGActionTogglePlayback], kGestureFrontTapDouble,

    /* Back defaults */
    [NSString stringWithFormat:@"%d", MGActionNextTrack], kGestureBackSwipeLeft,
    [NSString stringWithFormat:@"%d", MGActionPrevTrack], kGestureBackSwipeRight,

    [NSString stringWithFormat:@"%d", 30], kFrontSkipLength,
    
    nil];

}


/**
 * Fetches settings from the defaults plist and merges them with the hardcoded defaults
 */
static void reloadPreferences() {

  NSDictionary* defaultsDict 
    = [[NSDictionary alloc] initWithContentsOfFile:kDefaultsFilename];
  
  // Overwrite hardcoded defaults with user settings (if any exist)
  [preferencesDict addEntriesFromDictionary:defaultsDict];

  [defaultsDict release];

}


/**
 * Called when preferences are changed
 */
static void reloadPreferencesCallback(CFNotificationCenterRef center, 
                                      void* observer, CFStringRef name, 
                                      const void* object, CFDictionaryRef userInfo) {
  reloadPreferences();
}

%ctor {

  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

  %init;
  
  initDefaultPreferences();
  reloadPreferences();
  
  // Observe preferences changed notification
  CFNotificationCenterRef darwinNotificationCenter =
    CFNotificationCenterGetDarwinNotifyCenter();
    
  CFNotificationCenterAddObserver(darwinNotificationCenter,
                                  NULL,
                                  reloadPreferencesCallback,
                                  CFSTR(kPreferencesUpdated),
                                  NULL,
                                  CFNotificationSuspensionBehaviorCoalesce);

  [pool drain];

}
