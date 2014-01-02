/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "MusicGestures.h"
#import "legacy/IUNowPlayingAlbumFrontViewController.h"

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

%new
-(void)swipableView:(id)view pinchedToScale:(double)scale withVelocity:(double)velocity {

  [self performActionForKey:kGestureFrontPinch];
  
}

%new
-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(double)distance 
       withVelocity:(double)velocity {

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

%new
-(void)swipableView:(id)view
       longPressedInState:(UIGestureRecognizerState)state {

  if (state == UIGestureRecognizerStateBegan) {
  
    [self performLongPressBeginActionForKey:kGestureFrontLongPress];
  
  } else if (state == UIGestureRecognizerStateEnded) {
  
    [self performLongPressEndActionForKey:kGestureFrontLongPress];
  
  }
       
}

%end
