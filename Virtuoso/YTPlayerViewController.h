//
//  YTPlayerViewController.h
//  Virtuoso
//
//  Created by sikander.m on 12/2/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface YTPlayerViewController : UIViewController

@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;
@property (strong, nonatomic) NSString *videoID;

@end
