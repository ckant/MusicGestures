/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "IUNowPlayingAlbumBackViewController.h"
#import "MusicGestures.h"

@implementation IUNowPlayingAlbumBackViewController (MusicGestures)

-(void)swipableView:(id)view pinchedToScale:(double)scale withVelocity:(double)velocity {

  [self performActionForKey:kGestureBackPinch];

}

-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(double)distance 
       withVelocity:(double)velocity {

  switch(direction) {
    
    case MGSwipeUp:
      [self performPanActionForKey:kGestureBackSwipeUp
            inDirection:direction
            withDistance:distance
            withVelocity:velocity];
      break;
          
    case MGSwipeDown:
      [self performPanActionForKey:kGestureBackSwipeDown
            inDirection:direction
            withDistance:distance
            withVelocity:velocity];
      break;
    
    case MGSwipeLeft:
      [self performPanActionForKey:kGestureBackSwipeLeft
            inDirection:direction
            withDistance:distance
            withVelocity:velocity];
      break;
    
    case MGSwipeRight:
      [self performPanActionForKey:kGestureBackSwipeRight
            inDirection:direction
            withDistance:distance
            withVelocity:velocity];
      break;
          
  }

}

@end /* IUNowPlayingAlbumBackViewController (MusicGestures) */
