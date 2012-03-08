/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "IUNowPlayingFrontViewController.h"
#import "MusicGestures.h"

@implementation IUNowPlayingAlbumFrontViewController (MusicGestures)

-(void)swipableView:(id)view pinchedToScale:(float)scale withVelocity:(float)velocity {

  [self performActionForKey:kGestureFrontPinch];
  
}

-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(float)distance 
       withVelocity:(float)velocity {

  switch(direction) {
    
    case MGSwipeUp:
      [self performPanActionForKey:kGestureFrontSwipeUp
            inDirection:direction
            withDistance:distance
            withVelocity:velocity];
      break;
          
    case MGSwipeDown:
      [self performPanActionForKey:kGestureFrontSwipeDown
            inDirection:direction
            withDistance:distance
            withVelocity:velocity];
      break;
    
    case MGSwipeLeft:
      [self performPanActionForKey:kGestureFrontSwipeLeft
            inDirection:direction
            withDistance:distance
            withVelocity:velocity];
      break;
    
    case MGSwipeRight:
      [self performPanActionForKey:kGestureFrontSwipeRight
            inDirection:direction
            withDistance:distance
            withVelocity:velocity];
      break;
          
  }

}

-(void)swipableView:(id)view
       longPressedInState:(UIGestureRecognizerState)state {

  if (state == UIGestureRecognizerStateBegan) {
  
    [self performLongPressBeginActionForKey:kGestureFrontLongPress];
  
  } else if (state == UIGestureRecognizerStateEnded) {
  
    [self performLongPressEndActionForKey:kGestureFrontLongPress];
  
  }
       
}

@end /* IUNowPlayingAlbumFrontViewController (MusicGestures) */
