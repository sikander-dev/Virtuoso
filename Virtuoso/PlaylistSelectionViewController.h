//
//  PlaylistSelectionViewController.h
//  Virtuoso
//
//  Created by sikander.m on 12/21/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Playlist.h"

@protocol PlaylistSelectionDelegate <NSObject>

- (void)selectedPlaylist:(Playlist *)playlist;

@end

@interface PlaylistSelectionViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, assign) id <PlaylistSelectionDelegate> delegate;
@end



