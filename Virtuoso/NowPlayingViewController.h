//
//  NowPlayingViewController.h
//  Virtuoso
//
//  Created by sikander.m on 10/30/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NowPlayingViewController : UIViewController

@property (strong, nonatomic) MPMusicPlayerController *musicPlayer;

@end
