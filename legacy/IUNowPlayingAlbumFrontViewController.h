/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "MusicGestures.h"
#import "MPViewController.h"
#import "MPSwipableViewDelegate.h"

@interface IUNowPlayingAlbumFrontViewController : MPViewController <MPSwipableViewDelegate>
-(void)_handleSingleTap;
@end
