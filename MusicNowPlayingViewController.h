/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "MusicGestures.h"
#import "MPAVController.h"

@interface MusicNowPlayingViewController 

// Gesture recognizer actions
-(void)handleSwipe:(UISwipeGestureRecognizer*)swipeGestureRecognizer;
-(void)handleTapSingle:(UITapGestureRecognizer*)tapGestureRecognizer;
-(void)handleTapDouble:(UITapGestureRecognizer*)tapGestureRecognizer;
-(void)handleTapTriple:(UITapGestureRecognizer*)tapGestureRecognizer;
-(void)handleLongPress:(UILongPressGestureRecognizer*)longPressGestureRecognizer;
-(void)handlePinch:(UIPinchGestureRecognizer*)pinchGestureRecognizer;

// Translators from plist keys to corresponding actions
-(void)performActionForKey:(NSString*)key;
-(void)performLongPressBeginActionForKey:(NSString*)key;
-(void)performLongPressEndActionForKey:(NSString*)key;

// Actions
-(void)prevTrack;
-(void)nextTrack;
-(void)togglePlayback;
-(void)showFlipside;
-(void)showLyricsOrRating;
-(void)adjustVolumeBy:(double)delta;
-(void)beginSeek:(int)direction;
-(void)endSeek;
-(void)skipForward;
-(void)skipBackward;

// Convenience getters to manipulate state from within this controller
-(MPAVController*)player;
-(UIView*)contentView;

// Hook to add/modify gesture recognizers for the content view
-(void)addGestureRecognizersToContentView:(id)contentView;

@end
