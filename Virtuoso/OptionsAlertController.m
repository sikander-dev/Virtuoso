//
//  OptionsAlertController.m
//  Virtuoso
//
//  Created by sikander.m on 1/19/16.
//  Copyright © 2016 sikander.m. All rights reserved.
//

#import "OptionsAlertController.h"
#import "Playlist.h"

@interface OptionsAlertController ()

@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) NSNumber *persistentId;
@property (weak, nonatomic) NSManagedObjectContext *context;

@end

@implementation OptionsAlertController

- (id)initWithTitle:(NSString *)title andManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.context = context;
    [self addActionCancel];
    return self;
}

- (void)addActionAddToPlaylistForSongWithPersistentId:(NSNumber *)persistentId {
    for (UIAlertAction *action in [self.alertController actions]) {
        if ([action.title isEqualToString:@"Add to playlist"]) {
            return;
        }
    }
    UIAlertAction *addToPlaylistAction = [UIAlertAction actionWithTitle:@"Add to playlist" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self.delegate addToPlaylistActionSelectedFromAlertController:self];
    }];
    self.persistentId = persistentId;
    [self.alertController addAction:addToPlaylistAction];
}

- (void)addActionRemoveFromPlaylistForPlaylistTrack:(PlaylistTracks *)playlistTrack {
    for (UIAlertAction *action in [self.alertController actions]) {
        if ([action.title isEqualToString:@"Remove from playlist"]) {
            return;
        }
    }
    UIAlertAction *removeFromPlaylistAction = [UIAlertAction actionWithTitle:@"Remove from playlist" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.context deleteObject:playlistTrack];
    }];
    [self.alertController addAction:removeFromPlaylistAction];
}

- (void)addActionCancel {
    for (UIAlertAction *action in [self.alertController actions]) {
        if ([action.title isEqualToString:@"Cancel"]) {
            return;
        }
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [self.alertController addAction:cancelAction];
}


- (void)selectedPlaylist:(Playlist *)playlist {
    //self.selectedPlaylist = playlist;
    [PlaylistTracks addPlaylistTrackWithPersistentId:self.persistentId inPlaylist:playlist inManagedObjectContext:self.context];
}

- (void)presentOptionsAlertFromController:(UITableViewController *)controller {
    [controller presentViewController:self.alertController animated:nil completion:nil];
}

@end
