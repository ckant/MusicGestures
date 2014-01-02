/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MusicGestures.h"
#import "legacy/MPViewController.h"

%hook MPViewController

%new
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
      
    case MGActionShowFlipside:
      [self flip];
      break;
      
    case MGActionExitNowPlaying:
      [self exitNowPlaying];
      break;
      
    case MGActionShowLyricsOrRating:
      [self showInfoOverlay];
      break;

    case MGActionSkipBackward:
      [self skipBackward];
      break;

    case MGActionSkipForward:
      [self skipForward];
      break;
      
    case MGActionNone:
    default:
        break;
      
  }
  
}

%new
-(void)performPanActionForKey:(NSString*)key
       inDirection:(int)direction
       withDistance:(double)distance
       withVelocity:(double)velocity {

  NSNumber* actionNum = [preferencesDict objectForKey:key];
  MGAction action = (MGAction)[actionNum intValue];
        
  switch(action) {
        
    case MGActionAdjustVolume:
      if (direction == MGSwipeUp || direction == MGSwipeDown) {
        [self adjustVolumeBy:(-distance/120.0)];
      } else {
        [self adjustVolumeBy:(distance/120.0)];
      }
      break;
      
    default:
      break;
        
  }
       
}

%new
-(void)performLongPressBeginActionForKey:(NSString*)key {

  NSNumber* actionNum = [preferencesDict objectForKey:key];
  MGAction action = (MGAction)[actionNum intValue];

  switch(action) {
  
    case MGActionSeekForward:
      [self beginSeek:1];
      break;
    
    case MGActionSeekBackward:
      [self beginSeek:-1];
      break;
    
    default:
      [self performActionForKey:key];
      break;
  
  }

}

%new
-(void)performLongPressEndActionForKey:(NSString*)key {

  NSNumber* actionNum = [preferencesDict objectForKey:key];
  MGAction action = (MGAction)[actionNum intValue];

  switch(action) {
  
    case MGActionSeekForward:
    case MGActionSeekBackward:
      [self endSeek];
      break;
    
    default:
      break;
  
  }

}

%new
-(void)prevTrack {
  [[self player] changePlaybackIndexBy:-1];
}

%new
-(void)nextTrack {
  [[self player] changePlaybackIndexBy:1];
}

%new
-(void)togglePlayback {
  [[self player] togglePlayback];
}

%new
-(void)flip {
  // Method signature changed in iOS 6
  if ([[self delegate] respondsToSelector:@selector(_flip)]) {
    [[self delegate] _flip]; // iOS 6
  } else {
    [[self delegate] flip:self]; // iOS 4,5
  }
}

%new
-(void)exitNowPlaying {
  [[self delegate] _exitNowPlaying];
}

%new
-(void)showInfoOverlay {
  [self _handleSingleTap];
}

%new
-(void)adjustVolumeBy:(double)delta {
  [[self player] setVolume:[[self player] volume] + delta];
}

%new
-(void)beginSeek:(int)direction {
  [[self player] beginSeek:direction];
}

%new
-(void)endSeek {
  [[self player] endSeek];
}

%new
-(void)skipForward {
  int delta = [[preferencesDict objectForKey:kFrontSkipLength] intValue];
  [[self player] setCurrentTime:[[self player] currentTime] + delta];
}

%new
-(void)skipBackward {
  int delta = [[preferencesDict objectForKey:kFrontSkipLength] intValue];
  [[self player] setCurrentTime:[[self player] currentTime] - delta];
}

%end
