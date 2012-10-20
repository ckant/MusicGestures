
#import "MusicGestures.h"
#import "MPViewController.h"
#import <MediaPlayer/MPSwipableViewDelegate.h>

@interface IUNowPlayingAlbumFrontViewController 
  : MPViewController <MPSwipableViewDelegate> {}
-(void)_handleSingleTap;
@end

@interface IUNowPlayingAlbumFrontViewController (MusicGestures)
-(void)swipableView:(id)view pinchedToScale:(double)scale withVelocity:(double)velocity;
-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(double)distance 
       withVelocity:(double)velocity;
-(void)swipableView:(id)view
       longPressedInState:(UIGestureRecognizerState)state;
@end
