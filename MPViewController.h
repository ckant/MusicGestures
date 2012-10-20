/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "MusicGestures.h"
#import <MediaPlayer/MPViewController.h>

@interface IUiPodAVController : MPAVController {}
@end

@interface MPViewController (MusicGestures)
-(void)performActionForKey:(NSString*)key;
-(void)performPanActionForKey:(NSString*)key
       inDirection:(int)direction
       withDistance:(double)distance
       withVelocity:(double)velocity;
-(void)performLongPressBeginActionForKey:(NSString*)key;
-(void)performLongPressEndActionForKey:(NSString*)key;
       
-(void)prevTrack;
-(void)nextTrack;
-(void)togglePlayback;
-(void)flip;
-(void)exitNowPlaying;
-(void)showInfoOverlay;
-(void)adjustVolumeBy:(double)delta;
-(void)beginSeek:(int)direction;
-(void)endSeek;
-(IUiPodAVController*)player;
@end
