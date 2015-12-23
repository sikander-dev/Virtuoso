//
//  SongTableViewCell.h
//  Virtuoso
//
//  Created by sikander.m on 12/18/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Playlist.h"
#import "PlaylistTracks.h"

@protocol PerformSegueDelegate <NSObject>

- (void)segueWithIdentifier:(NSString *)identifier fromCell:(UITableViewCell *)cell;

@end

@interface SongTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *customCellTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *customCellDetailTextLabel;
@property (strong, nonatomic) UIAlertController *alertController;
@property (weak, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) MPMediaItem *song;

@property (weak, nonatomic) PlaylistTracks *playlistTrackObject;

@property (weak, nonatomic) id<PerformSegueDelegate> delegate;

- (void)addActionAddToPlaylist;

- (void)addActionRemoveFromPlaylist;

@end
