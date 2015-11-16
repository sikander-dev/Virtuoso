//
//  AlbumsViewController.m
//  Virtuoso
//
//  Created by sikander.m on 10/26/15.
//  Copyright (c) 2015 sikander.m. All rights reserved.
//

#import "AlbumsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AlbumSongsViewController.h"

@interface AlbumsViewController ()

@end

@implementation AlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Albums";
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
    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery collections];
    return [albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Album Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery collections];
    MPMediaItem *album = [albums[indexPath.row] representativeItem];
    cell.textLabel.text = [album valueForProperty:MPMediaItemPropertyAlbumTitle];
    cell.detailTextLabel.text = [album valueForProperty:MPMediaItemPropertyAlbumArtist];
    UIImage *artworkImage = [[album valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(44, 44)];
    if (artworkImage) {
        cell.imageView.image = artworkImage;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"no_artwork_image"];
    }
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AlbumSongsViewController *albumSongsViewController = [segue destinationViewController];
    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery items];
    MPMediaItem *selectedAlbum = albums[[[self.tableView indexPathForSelectedRow] row]];
    albumSongsViewController.albumTitle = [selectedAlbum valueForProperty:MPMediaItemPropertyAlbumTitle];
    albumSongsViewController.albumArtist = [selectedAlbum valueForProperty:MPMediaItemPropertyAlbumArtist];
    NSLog(@"AlbumSViewController prepared for segue");
}

@end








