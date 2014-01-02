/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import "MusicGestures.h"
#import "legacy/MPSwipableView.h"
#import "legacy/IUNowPlayingAlbumBackViewController.h"
#import "legacy/IUNowPlayingAlbumFrontViewController.h"

%hook MPSwipableView

-(id)initWithFrame:(CGRect)frame {

    id ret = %orig;
    
    if (ret) {
        
        UILongPressGestureRecognizer* longPressRecognizer =
          [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(_longPressGestureRecognized:)];
                                                
        longPressRecognizer.delegate = (id)self;
        longPressRecognizer.cancelsTouchesInView = NO;
        longPressRecognizer.delaysTouchesEnded = NO;
        [self addGestureRecognizer:longPressRecognizer];
        [longPressRecognizer release];
        
    }
    
    return ret;

}

/**
 * Called when a long press gesture is recognized
 */
%new
-(void)_longPressGestureRecognized:(id)recognized {

  [self.swipeDelegate swipableView:self
                      longPressedInState:[recognized state]];

}


%end
