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

static NSMutableDictionary* preferencesDict = nil;

/* Gestures */
static NSString* const kGestureFrontSwipeUp    = @"frontSwipeUp";
static NSString* const kGestureFrontSwipeDown  = @"frontSwipeDown";
static NSString* const kGestureFrontSwipeLeft  = @"frontSwipeLeft";
static NSString* const kGestureFrontSwipeRight = @"frontSwipeRight";

static NSString* const kGestureFrontTapSingle  = @"frontTapSingle";
static NSString* const kGestureFrontTapDouble  = @"frontTapDouble";
static NSString* const kGestureFrontTapTriple  = @"frontTapTriple";

static NSString* const kGestureFrontPinch      = @"frontPinch";

static NSString* const kGestureBackSwipeUp     = @"backSwipeUp";
static NSString* const kGestureBackSwipeDown   = @"backSwipeDown";
static NSString* const kGestureBackSwipeLeft   = @"backSwipeLeft";
static NSString* const kGestureBackSwipeRight  = @"backSwipeRight";

static NSString* const kGestureBackTapSingle   = @"backTapSingle";
static NSString* const kGestureBackTapDouble   = @"backTapDouble";
static NSString* const kGestureBackTapTriple   = @"backTapTriple";

static NSString* const kGestureBackPinch       = @"backPinch";


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


@implementation MPViewController (MusicGestures)

-(void)performActionForKey:(NSString*)key {

  NSNumber* actionNum = [preferencesDict objectForKey:key];
  MGAction action = (MGAction)[actionNum intValue];
  
  switch(action) {
  
    case MGActionPrevTrack:
      [self prevTrack];
      break;
    
    case MGActionNextTrack:
      [self nextTrack];
      break;          
      
    case MGActionTogglePlayback:
      [self togglePlayback];
      break;
      
    case MGActionFlip:
      [self flip];
      break;
      
    case MGActionExitNowPlaying:
      [self exitNowPlaying];
      break;
      
    case MGActionInfoOverlay:
      [self showInfoOverlay];
      break;
      
  }
  
}

-(void)prevTrack {
  [[self player] changePlaybackIndexBy:-1];
}

-(void)nextTrack {
  [[self player] changePlaybackIndexBy:1];
}

-(void)togglePlayback {
  [[self player] togglePlayback];
}

-(void)flip {
  [[self delegate] flip:self];
}

-(void)exitNowPlaying {
  [[self delegate] _exitNowPlaying];
}

-(void)showInfoOverlay {
  [self _handleSingleTap];
}

@end /* MPViewController (MusicGestures) */


@implementation IUNowPlayingAlbumFrontViewController (MusicGestures)

-(void)swipableView:(id)view pinchedToScale:(float)scale withVelocity:(float)velocity {

  [self performActionForKey:kGestureFrontPinch];
  
}

@end /* IUNowPlayingAlbumFrontViewController (MusicGestures) */


@implementation IUNowPlayingAlbumBackViewController (MusicGestures)
-(void)swipableView:(id)view pinchedToScale:(float)scale withVelocity:(float)velocity {

  [self performActionForKey:kGestureBackPinch];

}
@end /* IUNowPlayingAlbumBackViewController (MusicGestures) */


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
