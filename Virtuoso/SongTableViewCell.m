//
//  SongTableViewCell.m
//  Virtuoso
//
//  Created by sikander.m on 12/18/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "SongTableViewCell.h"
#import "PlaylistTracks.h"

@interface SongTableViewCell ()

//@property (weak, nonatomic) Playlist *selectedPlaylist;

@end

@implementation SongTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setupAlertController];
}

- (void)setupAlertController {
    self.alertController = [UIAlertController alertControllerWithTitle:@"More Options" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
}
- (IBAction)showOptions:(UIButton *)sender {
    [self.showAlertControllerDelegate showAlertController:self.alertController];
}

- (void)addActionAddToPlaylist {
    UIAlertAction *addToPlaylistAction = [UIAlertAction actionWithTitle:@"Add to playlist" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.performSegueDelegate segueWithIdentifier:@"Playlist Selection Segue" fromCell:self];
    }];
    [self.alertController addAction:addToPlaylistAction];
}

- (void)addActionRemoveFromPlaylist {
    UIAlertAction *removeFromPlaylistAction = [UIAlertAction actionWithTitle:@"Remove from playlist" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.managedObjectContext deleteObject:self.playlistTrackObject];
    }];
    [self.alertController addAction:removeFromPlaylistAction];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)selectedPlaylist:(Playlist *)playlist {
    //self.selectedPlaylist = playlist;
    [PlaylistTracks addPlaylistTrackWithPersistentId:[self.song valueForKey:MPMediaItemPropertyPersistentID] inPlaylist:playlist inManagedObjectContext:self.managedObjectContext];
}

@end
