//
//  SongsViewController.h
//  Virtuoso
//
//  Created by sikander.m on 10/23/15.
//  Copyright (c) 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongTableViewCell.h"
#import "PlaylistSelectionViewController.h"
#import "OptionsAlertController.h"

@interface SongsViewController : UITableViewController <PerformSegueDelegate, ShowAlertControllerDelegate>

@property (weak, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
