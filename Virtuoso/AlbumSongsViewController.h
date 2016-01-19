//
//  AlbumSongsViewController.h
//  Virtuoso
//
//  Created by sikander.m on 10/27/15.
//  Copyright (c) 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongTableViewCell.h"
#import "PlaylistSelectionViewController.h"
#import "OptionsAlertController.h"


@interface AlbumSongsViewController : UITableViewController <PerformSegueDelegate, ShowAlertControllerDelegate>

@property (strong, nonatomic) NSString *albumTitle;
@property (strong, nonatomic) NSString *albumArtist;
@property (nonatomic) NSUInteger albumSongCount;
@property (nonatomic) NSUInteger albumDurationInSec;
@property (strong, nonatomic) NSString *albumYear;
@property (strong, nonatomic) NSArray *albumSongs;
@property (strong, nonatomic) UIImage *albumArtwork;

@property (weak, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
