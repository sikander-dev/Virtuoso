//
//  YTResultsViewController.h
//  Virtuoso
//
//  Created by sikander.m on 12/1/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTResultsViewController : UITableViewController

@property (strong, nonatomic) NSString *queryString;
@property (strong, nonatomic) NSDictionary *results;

@end
