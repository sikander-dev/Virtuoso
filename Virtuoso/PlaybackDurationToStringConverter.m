//
//  PlaybackDurationToStringConverter.m
//  Virtuoso
//
//  Created by sikander.m on 11/30/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "PlaybackDurationToStringConverter.h"

@implementation PlaybackDurationToStringConverter

+ (NSString *)getStringFromPlaybackDuration:(NSNumber *)playbackDuration {
    
    NSTimeInterval duration = [playbackDuration doubleValue];
    NSUInteger minutes = duration/60;
    NSUInteger seconds = (NSUInteger)duration % (NSUInteger)60;
    NSString *playbackDurationString;
    if (seconds < 10) {
        playbackDurationString = [NSString stringWithFormat:@"%lu:0%lu", (unsigned long)minutes, (unsigned long)seconds];
    } else {
        playbackDurationString = [NSString stringWithFormat:@"%lu:%lu", (unsigned long)minutes, (unsigned long)seconds];
    }
    return playbackDurationString;
}

@end
