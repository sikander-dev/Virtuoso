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
#import "PlaylistSelectionViewController.h"

@class SongTableViewCell;

@protocol ShowAlertControllerDelegate <NSObject>

- (void)optionsButtonClickedFromCell:(SongTableViewCell *)cell;

@end

@interface SongTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *customCellTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *customCellDetailTextLabel;
@property (strong, nonatomic) MPMediaItem *song;

@property (strong, nonatomic) PlaylistTracks *playlistTrack;

@property (weak, nonatomic) id<ShowAlertControllerDelegate> delegate;

@end
