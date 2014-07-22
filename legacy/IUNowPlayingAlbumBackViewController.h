/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MusicGestures.h"
#import "MPViewController.h"
#import "MPSwipableViewDelegate.h"

@interface IUNowPlayingAlbumBackViewController : MPViewController <MPSwipableViewDelegate>

-(void)performActionForKey:(NSString*)key;

-(void)swipableView:(id)view swipedInDirection:(int)direction;
-(void)swipableView:(id)view tappedWithCount:(unsigned)count;

-(void)swipableView:(id)view pinchedToScale:(CGFloat)scale withVelocity:(CGFloat)velocity;
-(void)swipableView:(id)view pannedInDirection:(int)direction withDistance:(CGFloat)distance withVelocity:(CGFloat)velocity;

@end
