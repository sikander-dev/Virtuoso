//
//  YTPlayerViewController.m
//  Virtuoso
//
//  Created by sikander.m on 12/2/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "YTPlayerViewController.h"

@interface YTPlayerViewController ()

@end

@implementation YTPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *playerVars = @{@"playsinline" : @1, @"origin" : @"https://www.youtube.com"};
    [self.playerView loadWithVideoId:self.videoID playerVars:playerVars];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
