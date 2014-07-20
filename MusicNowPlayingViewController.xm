/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
#import "MusicGestures.h"
#import "MusicNowPlayingViewController.h"

%hook MusicNowPlayingViewController

-(id)_createContentViewForItem:(id)item contentViewController:(id*)contentViewController {
  id contentView = %orig;

  // Hook to add custom gesture recognizers to the content view
  [self addGestureRecognizersToContentView:contentView];

  return contentView;
}

/**
 * Album art / lyrics view
 */
%new
-(UIView*)contentView {
  return [self valueForKey:@"_contentView"];
}

/**
 * Audio/Video player
 */
%new
-(MPAVController*)player {
  return [[self valueForKey:@"_playbackControlsView"] valueForKey:@"_player"];
}

%new
-(void)handleSwipe:(UISwipeGestureRecognizer*)swipeGestureRecognizer {
  if (swipeGestureRecognizer.state != UIGestureRecognizerStateEnded) {
    return;
  }

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

%new
-(void)handleTapSingle:(UITapGestureRecognizer*)tapGestureRecognizer {
  [self performActionForKey:kGestureFrontTapSingle];
}

%new
-(void)handleTapDouble:(UITapGestureRecognizer*)tapGestureRecognizer {
  [self performActionForKey:kGestureFrontTapDouble];
}

%new
-(void)handleTapTriple:(UITapGestureRecognizer*)tapGestureRecognizer {
  [self performActionForKey:kGestureFrontTapTriple];
}

%new
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

%new
-(void)handlePinch:(UIPinchGestureRecognizer*)pinchGestureRecognizer {
  [self performActionForKey:kGestureFrontPinch];
}

%new
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

%new
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

%new
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

%new
-(void)prevTrack {
  MusicAVPlayer *workingPlayer = [%c(MusicAVPlayer) sharedAVPlayer];

  NSError *prevError;
  [workingPlayer changePlaybackIndexBy:-1 deltaType:0 ignoreElapsedTime:YES allowSkippingUnskippableContent:YES error:&prevError];

 // [workingPlayer changePlaybackIndexBy:-1];
 // [[self player] changePlaybackIndexBy:-1];
}

%new
-(void)nextTrack {
  [[self player] changePlaybackIndexBy:1];
}

%new
-(void)togglePlayback {
  [[self player] togglePlayback];
}

%new
-(void)showFlipside {
  [self _flipsideAction:nil];
}

/**
 * Toggle lyrics view if available, else ratings view
 */
%new
-(void)showLyricsOrRating {
  [self _tapAction:nil];
}

%new
-(void)adjustVolumeBy:(CGFloat)delta {
  [self player].volume = [self player].volume + delta;
}

%new
-(void)beginSeek:(int)direction {
  [[self player] beginSeek:direction];
}

%new
-(void)endSeek {
  [[self player] endSeek];
}

%new
-(void)skipForward {
  int delta = [[preferencesDict objectForKey:kFrontSkipLength] intValue];
  [self player].currentTime = [self player].currentTime + delta;
}

%new
-(void)skipBackward {
  int delta = [[preferencesDict objectForKey:kFrontSkipLength] intValue];
  [self player].currentTime = [self player].currentTime - delta;
}

%new
-(void)addGestureRecognizersToContentView:(id)contentView {
  // Remove all gesture recognizers
  while ([[contentView gestureRecognizers] count] > 0) {
    [contentView removeGestureRecognizer:[[contentView gestureRecognizers] objectAtIndex:0]];
  }

  // Add triple tap
  UITapGestureRecognizer* tapTripleRecognizer =
          [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapTriple:)];
  tapTripleRecognizer.delegate = (id)self;
  tapTripleRecognizer.numberOfTapsRequired = 3;
  [contentView addGestureRecognizer:tapTripleRecognizer];
  [tapTripleRecognizer release];

  // Add double tap; this toggles the flipside view by default
  UITapGestureRecognizer* tapDoubleRecognizer =
          [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapDouble:)];
  tapDoubleRecognizer.delegate = (id)self;
  tapDoubleRecognizer.numberOfTapsRequired = 2;
  [contentView addGestureRecognizer:tapDoubleRecognizer];
  [tapDoubleRecognizer requireGestureRecognizerToFail:tapTripleRecognizer];
  [tapDoubleRecognizer release];

  // Add single tap; this toggles the lyrics/ratings view by default
  UITapGestureRecognizer* tapSingleRecognizer =
          [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapSingle:)];
  tapSingleRecognizer.delegate = (id)self;
  tapSingleRecognizer.numberOfTapsRequired = 1;
  [contentView addGestureRecognizer:tapSingleRecognizer];
  [tapSingleRecognizer requireGestureRecognizerToFail:tapTripleRecognizer];
  [tapSingleRecognizer requireGestureRecognizerToFail:tapDoubleRecognizer];
  [tapSingleRecognizer release];

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


%end
