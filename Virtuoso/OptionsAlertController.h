//
//  OptionsAlertController.h
//  Virtuoso
//
//  Created by sikander.m on 1/19/16.
//  Copyright © 2016 sikander.m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlaylistTracks.h"
#import "PlaylistSelectionViewController.h"

@class OptionsAlertController;

@protocol PerformSegueDelegate <NSObject>

- (void)addToPlaylistActionSelectedFromAlertController:(OptionsAlertController *)alertController;

@end

@interface OptionsAlertController : NSObject <PlaylistSelectionDelegate>

@property (weak, nonatomic) id<PerformSegueDelegate> delegate;

- (id)initWithTitle:(NSString *)title andManagedObjectContext:(NSManagedObjectContext *)context;
- (void)addActionAddToPlaylistForSongWithPersistentId:(NSNumber *)persistentId;
- (void)addActionRemoveFromPlaylistForPlaylistTrack:(PlaylistTracks *)playlistTrack;

- (void)presentOptionsAlertFromController:(UITableViewController *)controller;

@end
