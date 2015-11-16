//
//  AlbumSongsViewController.h
//  Virtuoso
//
//  Created by sikander.m on 10/27/15.
//  Copyright (c) 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumSongsViewController : UITableViewController

@property (strong, nonatomic) NSString *albumTitle;
@property (strong, nonatomic) NSString *albumArtist;
@property (nonatomic) NSUInteger albumSongCount;
@property (nonatomic) NSUInteger albumDurationInSec;
@property (strong, nonatomic) NSString *albumYear;
@property (strong, nonatomic) NSArray *albumSongs;
@property (strong, nonatomic) UIImage *albumArtwork;
@end
