/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "IUNowPlayingBackViewController.h"
#import "MusicGestures.h"

@implementation IUNowPlayingAlbumBackViewController (MusicGestures)

-(void)swipableView:(id)view pinchedToScale:(float)scale withVelocity:(float)velocity {

  [self performActionForKey:kGestureBackPinch];

}

-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(float)distance 
       withVelocity:(float)velocity {

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
