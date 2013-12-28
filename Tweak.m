/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "MusicGestures.h"

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


%hook MusicNowPlayingViewController

-(id)_createContentViewForItem:(id)item contentViewController:(id*)contentViewController {
  id contentView = %orig;

  // Hook to add custom gesture recognizers to the content view
  [self addGestureRecognizersToContentView:contentView];

  return contentView;
}

%end // MusicNowPlayingViewController


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
