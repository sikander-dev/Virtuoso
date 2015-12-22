//
//  PlaylistsViewController.h
//  Virtuoso
//
//  Created by sikander.m on 12/14/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PlaylistsViewController : UITableViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
