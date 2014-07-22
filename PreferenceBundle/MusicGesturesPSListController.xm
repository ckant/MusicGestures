/**
 * Name:   MusicGestures
 * Pkg:    com.ckant.musicgestures
 * Author: Chris Kant (chriskant@gmail.com)
 * Date:   2012
 */

#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>

@interface MusicGesturesPSListController : PSListController
-(bool)isLegacy;
@end

@implementation MusicGesturesPSListController
-(id)specifiers {
  if (_specifiers == nil) {
    if ([self isLegacy]) {
      _specifiers = [[self loadSpecifiersFromPlistName:@"LegacyMusicGestures" target:self] retain];
    } else {
      _specifiers = [[self loadSpecifiersFromPlistName:@"MusicGestures" target:self] retain];
    }
  }
  return _specifiers;
}
-(bool)isLegacy {
  NSUInteger version = (NSUInteger)[[[UIDevice currentDevice] systemVersion] doubleValue];
  return (version < 7);
}

@end
