@protocol MPUNowPlayingDelegate <NSObject>
@optional
-(void)nowPlayingController:(id)controller nowPlayingApplicationDidChange:(id)nowPlayingApplication;
-(void)nowPlayingController:(id)controller elapsedTimeDidChange:(double)elapsedTime;
-(void)nowPlayingController:(id)controller playbackStateDidChange:(BOOL)playbackState;
-(void)nowPlayingController:(id)controller nowPlayingInfoDidChange:(id)nowPlayingInfo;
-(void)nowPlayingControllerDidStopListeningForNotifications:(id)nowPlayingController;
-(void)nowPlayingControllerDidBeginListeningForNotifications:(id)nowPlayingController;

@required
-(void)_flip;
-(void)_exitNowPlaying;

-(void)flip:(id)controller;

@end