//
//  AlbumSongsViewController.m
//  Virtuoso
//
//  Created by sikander.m on 10/27/15.
//  Copyright (c) 2015 sikander.m. All rights reserved.
//

#import "AlbumSongsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AlbumInfoCell.h"

@interface AlbumSongsViewController ()

@end

@implementation AlbumSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"AlbumSongsViewController being loaded");
    [self setAlbumProperties];
    NSLog(@"Album properties set");
    self.title = self.albumTitle;
    [self.tableView reloadData];
}

- (void)setAlbumProperties {
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumTitlePredicate = [MPMediaPropertyPredicate predicateWithValue:self.albumTitle forProperty:MPMediaItemPropertyAlbumTitle];
    MPMediaPropertyPredicate *albumArtistPredicate = [MPMediaPropertyPredicate predicateWithValue:self.albumArtist forProperty:MPMediaItemPropertyAlbumArtist];
    [albumQuery addFilterPredicate:albumTitlePredicate];
    [albumQuery addFilterPredicate:albumArtistPredicate];
    self.albumSongs = [albumQuery items];
    self.albumDurationInSec = 0;
    for (MPMediaItem *song in self.albumSongs) {
        self.albumDurationInSec += (NSUInteger)[song valueForProperty:MPMediaItemPropertyPlaybackDuration];
    }
    for (MPMediaItem *song in self.albumSongs) {
        UIImage *artworkImage = [[song valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(1, 1)];
        if(artworkImage) {
            self.albumArtwork = artworkImage;
            break;
        }
    }
    for (MPMediaItem *song in self.albumSongs) {
        NSString *albumYear = [song valueForProperty:@"year"];
        if (albumYear) {
            self.albumYear = albumYear;
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"No. of rows = %lu", [self.albumSongs count] + 1);
    return ([self.albumSongs count] + 1);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath called for %lu", indexPath.row);
    if (indexPath.row == 0) {
        AlbumInfoCell *cell = (AlbumInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"Album Info Cell" forIndexPath:indexPath];
        cell.albumArtistLabel.text = self.albumArtist;
        cell.albumDurationLabel.text = [NSString stringWithFormat:@"%lu songs %lum %lus", (unsigned long)[self.albumSongs count], self.albumDurationInSec/60, self.albumDurationInSec % 60];
        cell.albumYearLabel.text = [NSString stringWithFormat:@"%@", self.albumYear];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Album Song Cell" forIndexPath:indexPath];
        MPMediaItem *song = self.albumSongs[indexPath.row-1];
        cell.textLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
        NSUInteger songDuration = (NSUInteger)[song valueForProperty:MPMediaItemPropertyPlaybackDuration];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu:%lu", songDuration/60, songDuration%60];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0) {
        return 150;
    }
    return 44;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController systemMusicPlayer];
    [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:self.albumSongs]];
    [musicPlayer setNowPlayingItem:self.albumSongs[[[self.tableView indexPathForSelectedRow] row] - 1]];
    [musicPlayer play];
}


@end








