/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MusicGestures.h"
#import <MediaPlayer/MPSwipableView.h>

@interface MPSwipableView (MusicGestures)
-(void)_panGestureRecognized:(id)recognized;
-(void)_longPressGestureRecognized:(id)recognized;
-(MGSwipe)_panDirectionForPoint:(CGPoint)point;
-(float)_panDistanceForPoint:(CGPoint)point inDirection:(MGSwipe)direction;
-(float)_panVelocityForPoint:(CGPoint)point inDirection:(MGSwipe)direction;
@end
