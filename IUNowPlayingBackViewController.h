
#import "MusicGestures.h"
#import "MPViewController.h"
#import <MediaPlayer/MPSwipableViewDelegate.h>

@interface IUNowPlayingAlbumBackViewController 
  : MPViewController <MPSwipableViewDelegate> {}
@end

@interface IUNowPlayingAlbumBackViewController (MusicGestures)
-(void)swipableView:(id)view pinchedToScale:(float)scale withVelocity:(float)velocity;
-(void)swipableView:(id)view 
       pannedInDirection:(int)direction 
       withDistance:(float)distance 
       withVelocity:(float)velocity;
@end
