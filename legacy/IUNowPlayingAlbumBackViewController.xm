/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MusicGestures.h"
#import "legacy/IUNowPlayingAlbumBackViewController.h"

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

%new
-(void)swipableView:(id)view pinchedToScale:(CGFloat)scale withVelocity:(CGFloat)velocity {

  [self performActionForKey:kGestureBackPinch];

}

%new
-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(CGFloat)distance 
       withVelocity:(CGFloat)velocity {

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

%end
