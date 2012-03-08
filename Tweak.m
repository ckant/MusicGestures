/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "MusicGestures.h"
#import "MPViewController.h"
#import "MPSwipableView.h"
#import "IUNowPlayingFrontViewController.h"
#import "IUNowPlayingBackViewController.h"


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


/**
 * Creates a dictionary with defaults
 */
static void initDefaultPreferences() {

  preferencesDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    
    /* Front defaults */
    [NSString stringWithFormat:@"%d", MGActionNextTrack], kGestureFrontSwipeLeft,
    [NSString stringWithFormat:@"%d", MGActionPrevTrack], kGestureFrontSwipeRight,
    [NSString stringWithFormat:@"%d", MGActionInfoOverlay], kGestureFrontTapSingle,
    [NSString stringWithFormat:@"%d", MGActionTogglePlayback], kGestureFrontTapDouble,
    
    /* Back defaults */
    [NSString stringWithFormat:@"%d", MGActionNextTrack], kGestureBackSwipeLeft,
    [NSString stringWithFormat:@"%d", MGActionPrevTrack], kGestureBackSwipeRight,
    
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


%hook IUNowPlayingAlbumFrontViewController 

-(void)swipableView:(id)view swipedInDirection:(int)direction {

  switch(direction) {
  
    case MGSwipeUp:
      [self performActionForKey:kGestureFrontSwipeUp];
      break;
      
    case MGSwipeDown:
      [self performActionForKey:kGestureFrontSwipeDown];
      break;
    
    case MGSwipeLeft:
      [self performActionForKey:kGestureFrontSwipeLeft];
      break;
    
    case MGSwipeRight:
      [self performActionForKey:kGestureFrontSwipeRight];
      break;
  }
                 
}

-(void)swipableView:(id)view tappedWithCount:(unsigned)count {

  switch(count) {
  
    case MGTapSingle:
      [self performActionForKey:kGestureFrontTapSingle];
      break;
      
    case MGTapDouble:
      [self performActionForKey:kGestureFrontTapDouble];
      break;
      
    case MGTapTriple:
      [self performActionForKey:kGestureFrontTapTriple];
      break;
  
  }
                 
}

%end /* hook IUNowPlayingAlbumFrontViewController */


%hook IUNowPlayingAlbumBackViewController 

-(void)swipableView:(id)view swipedInDirection:(int)direction {

  switch(direction) {
  
    case MGSwipeUp:
      [self performActionForKey:kGestureBackSwipeUp];
      break;
      
    case MGSwipeDown:
      [self performActionForKey:kGestureBackSwipeDown];
      break;
    
    case MGSwipeLeft:
      [self performActionForKey:kGestureBackSwipeLeft];
      break;
    
    case MGSwipeRight:
      [self performActionForKey:kGestureBackSwipeRight];
      break;
  }
                 
}

-(void)swipableView:(id)view tappedWithCount:(unsigned)count {

  switch(count) {
  
    case MGTapSingle:
      [self performActionForKey:kGestureBackTapSingle];
      break;
      
    case MGTapDouble:
      [self performActionForKey:kGestureBackTapDouble];
      break;
      
    case MGTapTriple:
      [self performActionForKey:kGestureBackTapTriple];
      break;
  
  }

}

%end /* hook IUNowPlayingAlbumBackViewController */


%hook MPSwipableView

-(id)initWithFrame:(CGRect)frame {

    id ret = %orig;
    
    if (ret) {
    
        UIPanGestureRecognizer* panRecognizer = 
          [[UIPanGestureRecognizer alloc] initWithTarget:self 
                                          action:@selector(_panGestureRecognized:)];
        panRecognizer.delegate = self;
        panRecognizer.cancelsTouchesInView = NO;
        panRecognizer.delaysTouchesEnded = NO;
        [self addGestureRecognizer:panRecognizer];
        [panRecognizer release];
        
        UILongPressGestureRecognizer* longPressRecognizer =
          [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(_longPressGestureRecognized:)];
                                                
        longPressRecognizer.delegate = self;
        longPressRecognizer.cancelsTouchesInView = NO;
        longPressRecognizer.delaysTouchesEnded = NO;
        [self addGestureRecognizer:longPressRecognizer];
        [longPressRecognizer release];
        
    }
    
    return ret;

}

%end /* hook MPSwipableView */


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
