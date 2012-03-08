
#import "MusicGestures.h"
#import "MPViewController.h"
#import <MediaPlayer/MPSwipableViewDelegate.h>

@interface IUNowPlayingAlbumFrontViewController 
  : MPViewController <MPSwipableViewDelegate> {}
-(void)_handleSingleTap;
@end

@interface IUNowPlayingAlbumFrontViewController (MusicGestures)
-(void)swipableView:(id)view pinchedToScale:(float)scale withVelocity:(float)velocity;
-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(float)distance 
       withVelocity:(float)velocity;
-(void)swipableView:(id)view
       longPressedInState:(UIGestureRecognizerState)state;
@end
