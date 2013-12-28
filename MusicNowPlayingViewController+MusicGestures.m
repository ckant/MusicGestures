/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MusicGestures.h"
#import "MusicNowPlayingViewController+MusicGestures.h"

@implementation MusicNowPlayingViewController (MusicGestures)

/**
 * Album art / lyrics view
 */
-(UIView*)contentView {
  return [self valueForKey:@"_contentView"];
}

/**
 * Audio/Video player
 */
-(MPAVController*)player {
  return [[self valueForKey:@"_playbackControlsView"] valueForKey:@"_player"];
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)swipeGestureRecognizer {
  switch(swipeGestureRecognizer.direction) {
    case UISwipeGestureRecognizerDirectionRight:
      [self performActionForKey:kGestureFrontSwipeRight];
      break;

    case UISwipeGestureRecognizerDirectionLeft:
      [self performActionForKey:kGestureFrontSwipeLeft];
      break;

    case UISwipeGestureRecognizerDirectionUp:
      [self performActionForKey:kGestureFrontSwipeUp];
      break;

    case UISwipeGestureRecognizerDirectionDown:
      [self performActionForKey:kGestureFrontSwipeDown];
      break;
  }
}

-(void)handleTapSingle:(UITapGestureRecognizer*)tapGestureRecognizer {
  [self performActionForKey:kGestureFrontTapSingle];
}

-(void)handleTapDouble:(UITapGestureRecognizer*)tapGestureRecognizer {
  [self performActionForKey:kGestureFrontTapDouble];
}

-(void)handleTapTriple:(UITapGestureRecognizer*)tapGestureRecognizer {
  [self performActionForKey:kGestureFrontTapTriple];
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)longPressGestureRecognizer {
  switch(longPressGestureRecognizer.state) {
    case UIGestureRecognizerStateBegan:
      [self performLongPressBeginActionForKey:kGestureFrontLongPress];
      break;
    
    case UIGestureRecognizerStateEnded:
      [self performLongPressEndActionForKey:kGestureFrontLongPress];
      break;
  }
}

-(void)handlePinch:(UIPinchGestureRecognizer*)pinchGestureRecognizer {
  [self performActionForKey:kGestureFrontPinch];
}

-(void)performActionForKey:(NSString*)key {

  NSNumber* actionNum = [preferencesDict objectForKey:key];
  MGAction action = (MGAction)[actionNum intValue];
  
  switch(action) {
  
    case MGActionPrevTrack:
      [self prevTrack];
      break;
    
    case MGActionNextTrack:
      [self nextTrack];
      break;          
      
    case MGActionTogglePlayback:
      [self togglePlayback];
      break;
      
    case MGActionShowFlipside:
      [self showFlipside];
      break;
      
    case MGActionShowLyricsOrRating:
      [self showLyricsOrRating];
      break;

    case MGActionSkipBackward:
      [self skipBackward];
      break;

    case MGActionSkipForward:
      [self skipForward];
      break;
      
    case MGActionNone:
    default:
        break;
      
  }
  
}

-(void)performLongPressBeginActionForKey:(NSString*)key {

  NSNumber* actionNum = [preferencesDict objectForKey:key];
  MGAction action = (MGAction)[actionNum intValue];

  switch(action) {
  
    case MGActionSeekForward:
      [[self player] beginSeek:1];
      break;
    
    case MGActionSeekBackward:
      [[self player] beginSeek:-1];
      break;
    
    default:
      [self performActionForKey:key];
      break;
  
  }

}

-(void)performLongPressEndActionForKey:(NSString*)key {

  NSNumber* actionNum = [preferencesDict objectForKey:key];
  MGAction action = (MGAction)[actionNum intValue];

  switch(action) {
  
    case MGActionSeekForward:
    case MGActionSeekBackward:
      [[self player] endSeek];
      break;
    
    default:
      break;
  
  }

}

-(void)prevTrack {
  [[self player] changePlaybackIndexBy:-1];
}

-(void)nextTrack {
  [[self player] changePlaybackIndexBy:1];
}

-(void)togglePlayback {
  [[self player] togglePlayback];
}

-(void)showFlipside {
  [self _flipsideAction:nil];
}

/**
 * Toggle lyrics view if available, else ratings view
 */
-(void)showLyricsOrRating {
  [self _tapAction:nil];
}

-(void)adjustVolumeBy:(double)delta {
  [self player].volume = [self player].volume + delta;
}

-(void)beginSeek:(int)direction {
  [[self player] beginSeek:direction];
}

-(void)endSeek {
  [[self player] endSeek];
}

-(void)skipForward {
  int delta = [[preferencesDict objectForKey:kFrontSkipLength] intValue];
  [self player].currentTime = [self player].currentTime + delta;
}

-(void)skipBackward {
  int delta = [[preferencesDict objectForKey:kFrontSkipLength] intValue];
  [self player].currentTime = [self player].currentTime - delta;
}

-(void)addGestureRecognizersToContentView:(id)contentView {
  // Add triple tap
  UITapGestureRecognizer* tapTripleRecognizer =
          [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapTriple:)];             
  tapTripleRecognizer.delegate = (id)self;
  tapTripleRecognizer.numberOfTapsRequired = 3;
  [contentView addGestureRecognizer:tapTripleRecognizer];
  [tapTripleRecognizer release];

  // Customize double tap; this toggles the flipside view by default
  UITapGestureRecognizer* tapDoubleRecognizer = [contentView gestureRecognizers][0];
  [tapDoubleRecognizer removeTarget:nil action:NULL];
  [tapDoubleRecognizer addTarget:self action:@selector(handleTapDouble:)];
  [tapDoubleRecognizer requireGestureRecognizerToFail:tapTripleRecognizer];

  // Customize single tap; this toggles the lyrics/ratings view by default
  UITapGestureRecognizer* tapSingleRecognizer = [contentView gestureRecognizers][1];
  [tapSingleRecognizer removeTarget:nil action:NULL];
  [tapSingleRecognizer addTarget:self action:@selector(handleTapSingle:)];
  [tapSingleRecognizer requireGestureRecognizerToFail:tapTripleRecognizer];

  // Add long press
  UILongPressGestureRecognizer* longPressRecognizer =
          [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleLongPress:)];
  longPressRecognizer.delegate = (id)self;
  [contentView addGestureRecognizer:longPressRecognizer];
  [longPressRecognizer release];

  // Add pinch
  UIPinchGestureRecognizer* pinchRecognizer =
          [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlePinch:)];
  pinchRecognizer.delegate = (id)self;
  [contentView addGestureRecognizer:pinchRecognizer];
  [pinchRecognizer release];

  // Add swipe right
  UISwipeGestureRecognizer* swipeRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(handleSwipe:)];
  swipeRecognizer.delegate = (id)self;
  swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
  [contentView addGestureRecognizer:swipeRecognizer];
  [swipeRecognizer release];

  // Add swipe left
  swipeRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(handleSwipe:)];
  swipeRecognizer.delegate = (id)self;
  swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
  [contentView addGestureRecognizer:swipeRecognizer];
  [swipeRecognizer release];

  // Add swipe up
  swipeRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(handleSwipe:)];
  swipeRecognizer.delegate = (id)self;
  swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
  [contentView addGestureRecognizer:swipeRecognizer];
  [swipeRecognizer release];

  // Add swipe down
  swipeRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(handleSwipe:)];
  swipeRecognizer.delegate = (id)self;
  swipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
  [contentView addGestureRecognizer:swipeRecognizer];
  [swipeRecognizer release];
}


@end /* MPViewController (MusicGestures) */
