/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MusicGestures.h"
#import "MPSwipableViewDelegate.h"

@interface MPSwipableView : UIView

@property (nonatomic, retain) id<MPSwipableViewDelegate> swipeDelegate;

@end

