//
//  PlaylistSongsViewController.h
//  Virtuoso
//
//  Created by sikander.m on 12/22/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Playlist.h"

@interface PlaylistSongsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) Playlist *playlist;

@end
