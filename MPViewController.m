/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MusicGestures.h"
#import "MPViewController.h"

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
      
    default:
        break;
      
  }
  
}

-(void)performPanActionForKey:(NSString*)key
       inDirection:(int)direction
       withDistance:(float)distance
       withVelocity:(float)velocity {

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

-(void)adjustVolumeBy:(float)delta {
  [self player].volume = [self player].volume + delta;
}

-(void)beginSeek:(int)direction {
  [[self player] beginSeek:direction];
}

-(void)endSeek {
  [[self player] endSeek];
}

@end /* MPViewController (MusicGestures) */
