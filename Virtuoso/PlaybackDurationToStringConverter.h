//
//  PlaybackDurationToStringConverter.h
//  Virtuoso
//
//  Created by sikander.m on 11/30/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaybackDurationToStringConverter : NSObject

+ (NSString *)getStringFromPlaybackDuration: (NSNumber *)playbackDuration;
//+ (NSString *)getStringFromPlaybackDuration: (NSUInteger)playbackDuration;


@end
