/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import <MediaPlayer/MPViewController.h>
#import <MediaPlayer/MPSwipableViewDelegate.h>

typedef enum {
  MGSwipeUp    = 1,
  MGSwipeDown  = 2,
  MGSwipeLeft  = 3,
  MGSwipeRight = 4
} MGSwipe;

typedef enum {
  MGTapSingle = 1,
  MGTapDouble = 2,
  MGTapTriple = 3
} MGTap;

typedef enum {
  MGActionPrevTrack       = 1,
  MGActionNextTrack       = 2,
  MGActionTogglePlayback  = 3,
  MGActionFlip            = 4,
  MGActionExitNowPlaying  = 5,
  MGActionInfoOverlay     = 6
} MGAction;

@interface IUNowPlayingAlbumFrontViewController 
  : MPViewController <MPSwipableViewDelegate> {}
-(void)_handleSingleTap;
@end

@interface IUNowPlayingAlbumBackViewController 
  : MPViewController <MPSwipableViewDelegate> {}
@end

/* Added Methods  */

@interface MPViewController (MusicGestures)
-(void)performActionForKey:(NSString*)key;
-(void)prevTrack;
-(void)nextTrack;
-(void)togglePlayback;
-(void)flip;
-(void)exitNowPlaying;
-(void)showInfoOverlay;
@end

@interface IUNowPlayingAlbumFrontViewController (MusicGestures)
-(void)swipableView:(id)view pinchedToScale:(float)scale withVelocity:(float)velocity;
@end

@interface IUNowPlayingAlbumBackViewController (MusicGestures)
-(void)swipableView:(id)view pinchedToScale:(float)scale withVelocity:(float)velocity;
@end
