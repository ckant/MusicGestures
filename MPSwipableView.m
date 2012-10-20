/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MPSwipableView.h"
#import "IUNowPlayingAlbumBackViewController.h"
#import "IUNowPlayingAlbumFrontViewController.h"
#import "MusicGestures.h"

@implementation MPSwipableView (MusicGestures)

static MGSwipe panLast;
static int panStreak = 0;
static BOOL validSwipe = YES;

/**
 * Returns estimated direction of pan
 */
-(MGSwipe)_panDirectionForPoint:(CGPoint)point {

    if (abs(point.x) > abs(point.y)) {
        return (point.x < 0 ? MGSwipeLeft : MGSwipeRight); 
    
    } else if (abs(point.x) < abs(point.y)) {
        return (point.y < 0 ? MGSwipeUp : MGSwipeDown); 
    
    }
    
    return MGSwipeNone;

}


/**
 * Returns distance panned for direction
 */
-(double)_panDistanceForPoint:(CGPoint)point inDirection:(MGSwipe)direction {

    if (direction == MGSwipeLeft || direction == MGSwipeRight) {
        return point.x;
    } else {
        return point.y;
    }

}


/**
 * Returns velocity panned for direction
 */
-(double)_panVelocityForPoint:(CGPoint)point inDirection:(MGSwipe)direction {

    if (direction == MGSwipeLeft || direction == MGSwipeRight) {
        return point.x;
    } else {
        return point.y;
    }

}


/**
 * Called when a pan gesture is recognized
 */
-(void)_panGestureRecognized:(id)recognized {
    CGPoint translation = [recognized translationInView:self]; // get translation
    [recognized setTranslation:CGPointMake(0, 0) inView:self]; // reset
    
    CGPoint rawVelocity = [recognized velocityInView:self];
    
    MGSwipe direction;
    int panThreshold = 1;
    
    direction = [self _panDirectionForPoint:translation];
    
    if ([recognized state] == UIGestureRecognizerStateBegan) {
        panStreak = 1;
        panLast = direction;
        validSwipe = YES;
        return;
    }    
    
    if (validSwipe == NO || direction == MGSwipeNone) return; 

    if (panStreak < panThreshold) {
    
        switch(direction) {
        
            case MGSwipeLeft:
            case MGSwipeRight:
                if (panLast == MGSwipeLeft || panLast == MGSwipeRight) {
                    panStreak++;
                } else {
                    validSwipe = NO;
                }
                break;
            
            case MGSwipeUp:
            case MGSwipeDown:
                if (panLast == MGSwipeUp || panLast == MGSwipeDown) {
                    panStreak++;
                } else {
                    validSwipe = NO;
                }
                break;
                
            default:
              break;
        
        }
    
    } else {
        // Send pan in pan streak direction
        // Allows you to move right then back left and keep same pan motion registered
        
        [self.swipeDelegate swipableView:self
                            pannedInDirection:panLast 
                            withDistance:[self _panDistanceForPoint:translation 
                                               inDirection:panLast]
                            withVelocity:[self _panVelocityForPoint:rawVelocity 
                                               inDirection:panLast]];
        
    }
    
}


/**
 * Called when a long press gesture is recognized
 */
-(void)_longPressGestureRecognized:(id)recognized {

  [self.swipeDelegate swipableView:self
                      longPressedInState:[recognized state]];

}


@end
