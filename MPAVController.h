/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */
 
@interface MPAVController

@property (assign,nonatomic) CGFloat currentTime;
@property (assign,nonatomic) CGFloat volume;

-(void)togglePlayback;
-(void)changePlaybackIndexBy:(NSInteger)by;
-(void)beginSeek:(NSInteger)seek;
-(void)endSeek;

- (BOOL)changePlaybackIndexBy:(NSInteger)arg1 deltaType:(NSInteger)arg2 ignoreElapsedTime:(BOOL)arg3 allowSkippingUnskippableContent:(BOOL)arg4 error:(id*)arg5;

@end

@interface MusicAVPlayer : MPAVController

+ (id)sharedAVPlayer;

@end
