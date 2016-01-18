//
//  SongsViewController.m
//  Virtuoso
//
//  Created by sikander.m on 10/23/15.
//  Copyright (c) 2015 sikander.m. All rights reserved.
//

#import "SongsViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SongsViewController ()

@end

@implementation SongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Songs";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    NSArray *songs = [songsQuery items];
    return [songs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Song Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    NSArray *songs = [songsQuery items];
    MPMediaItem *song = songs[indexPath.row];
    cell.customCellTextLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
    cell.customCellDetailTextLabel.text = [song valueForProperty:MPMediaItemPropertyArtist];
    cell.song = song;
    cell.managedObjectContext = self.managedObjectContext;
    [cell setPerformSegueDelegate:self];
    [cell setShowAlertControllerDelegate:self];
    [cell addActionAddToPlaylist];
    return cell;
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

- (void)showAlertController:(UIAlertController *)alertController {
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Navigation

- (void)segueWithIdentifier:(NSString *)identifier fromCell:(SongTableViewCell *)cell{
    [self performSegueWithIdentifier:identifier sender:cell];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Playlist Selection Segue"]) {
        PlaylistSelectionViewController *playlistSelectionViewController = [segue destinationViewController];
        SongTableViewCell *cell = (SongTableViewCell *)sender;
        //NSLog(@"sender = %@\ncell = %@", sender, cell);
        [playlistSelectionViewController setDelegate:cell];
        playlistSelectionViewController.managedObjectContext = self.managedObjectContext;
    } else {
        //NSLog(@"sender = %@", sender);
        MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
        NSArray *songs = [songsQuery items];
        MPMusicPlayerController *musicPlayer = [MPMusicPlayerController systemMusicPlayer];
        BOOL shuffleWasOn = NO;
        //NSLog(@"shuffleMode = %ld", (long)musicPlayer.shuffleMode);
        if (musicPlayer.shuffleMode != MPMusicShuffleModeOff)
        {
            musicPlayer.shuffleMode = MPMusicShuffleModeOff;
            shuffleWasOn = YES;
        }
        [musicPlayer pause];
        NSLog(@"plabackState = %ld", (long)musicPlayer.playbackState);
        [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:songs]];
        [musicPlayer setNowPlayingItem:songs[[[self.tableView indexPathForSelectedRow] row]]];
        SongTableViewCell *cell = (SongTableViewCell *)sender;
        //[musicPlayer setNowPlayingItem:cell.song];
        NSLog(@"song = %@", [cell.song valueForKey:MPMediaItemPropertyTitle]);
        //NSLog(@"shuffleMode = %ld", (long)musicPlayer.shuffleMode);
        NSLog(@"now playing = %@", [musicPlayer.nowPlayingItem valueForKey:MPMediaItemPropertyTitle]);
        if (shuffleWasOn)
            musicPlayer.shuffleMode = MPMusicShuffleModeSongs;
        [musicPlayer play];
        //NSLog(@"shuffleMode = %ld", (long)musicPlayer.shuffleMode);
        NSLog(@"now playing = %@", [musicPlayer.nowPlayingItem valueForKey:MPMediaItemPropertyTitle]);
    }
}


@end













