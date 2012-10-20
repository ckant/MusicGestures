
#import "MusicGestures.h"
#import "MPViewController.h"
#import <MediaPlayer/MPSwipableViewDelegate.h>

@interface IUNowPlayingAlbumBackViewController 
  : MPViewController <MPSwipableViewDelegate> {}
@end

@interface IUNowPlayingAlbumBackViewController (MusicGestures)
-(void)swipableView:(id)view pinchedToScale:(double)scale withVelocity:(double)velocity;
-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(double)distance 
       withVelocity:(double)velocity;
@end
