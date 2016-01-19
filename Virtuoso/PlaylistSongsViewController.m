//
//  PlaylistSongsViewController.m
//  Virtuoso
//
//  Created by sikander.m on 12/22/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "PlaylistSongsViewController.h"
#import "PlaylistSelectionViewController.h"

@interface PlaylistSongsViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSArray *songArray;

@end

@implementation PlaylistSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = self.playlist.name;
    [self initializeFetchedResultsController];
    NSArray *fetchedObjects = [self.fetchedResultsController fetchedObjects];
    NSMutableArray *songArray;
    for (PlaylistTracks *playlistTrack in fetchedObjects) {
        [songArray addObject:[self getSongFromPersistentId:playlistTrack.persistentId]];
    }
    self.songArray = songArray;
}

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PlaylistTracks"];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"persistentId" ascending:YES];
    [request setSortDescriptors:@[nameSort]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"playlist = %@", self.playlist]];
    //NSLog(@"playlist name = %@", self.playlist.name);
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil]];
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failsed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    //NSLog(@"number of rows = %lu", [[[self fetchedResultsController] sections][section] numberOfObjects]);
    return [[[self fetchedResultsController] sections][section] numberOfObjects];
}

- (void)configureCell:(id)cell atIndexPath:(NSIndexPath*)indexPath {
    id object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    PlaylistTracks *playlistTrack = (PlaylistTracks *)object;
    SongTableViewCell *songTableViewCell = (SongTableViewCell *)cell;
    //NSLog(@"playlistTrack = %@", playlistTrack);
    MPMediaItem *song = [self getSongFromPersistentId:playlistTrack.persistentId];
    songTableViewCell.customCellTextLabel.text = [song valueForKey:MPMediaItemPropertyTitle];
    songTableViewCell.customCellDetailTextLabel.text = [song valueForProperty:MPMediaItemPropertyArtist];
    songTableViewCell.playlistTrack = playlistTrack;
    songTableViewCell.song = song;
    [songTableViewCell setDelegate:self];
}

- (MPMediaItem *)getSongFromPersistentId:(NSNumber *)persistentId {
    MPMediaQuery *songQuery = [MPMediaQuery songsQuery];
    if (!persistentId) {
        NSLog(@"YES");
    } else {
    MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:persistentId forProperty:MPMediaItemPropertyPersistentID];
    [songQuery addFilterPredicate:predicate];
    if ([songQuery items].count == 1) {
        //NSLog(@"[songQuery items] = %@",[songQuery items]);
        return [[songQuery items] firstObject];
    }}
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Playlist Song Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [[self tableView] beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[[self tableView] cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [[self tableView] endUpdates];
}

- (void)optionsButtonClickedFromCell:(SongTableViewCell *)cell {
    OptionsAlertController *alertController = [[OptionsAlertController alloc] initWithTitle:@"More options" andManagedObjectContext:self.managedObjectContext];
    [alertController setDelegate:self];
    [alertController addActionAddToPlaylistForSongWithPersistentId:[cell.song valueForKey:MPMediaEntityPropertyPersistentID]];
    [alertController addActionRemoveFromPlaylistForPlaylistTrack:cell.playlistTrack];
    [alertController presentOptionsAlertFromController:self];
}

#pragma mark - Navigation

- (void)addToPlaylistActionSelectedFromAlertController:(OptionsAlertController *)alertController {
    [self performSegueWithIdentifier:@"Playlist Selection Segue" sender:alertController];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Playlist Selection Segue"]) {
        PlaylistSelectionViewController *playlistSelectionViewController = [segue destinationViewController];
        OptionsAlertController *alertController = (OptionsAlertController *)sender;
        [playlistSelectionViewController setDelegate:alertController];
        playlistSelectionViewController.managedObjectContext = self.managedObjectContext;
    } else {
        MPMusicPlayerController *musicPlayer = [MPMusicPlayerController systemMusicPlayer];
        BOOL shuffleWasOn = NO;
        if (musicPlayer.shuffleMode != MPMusicShuffleModeOff)
        {
            musicPlayer.shuffleMode = MPMusicShuffleModeOff;
            shuffleWasOn = YES;
        }
        [musicPlayer pause];
        [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:self.songArray]];
        [musicPlayer setNowPlayingItem:self.songArray[[[self.tableView indexPathForSelectedRow] row]]];
        if (shuffleWasOn)
            musicPlayer.shuffleMode = MPMusicShuffleModeSongs;
        [musicPlayer play];
    }
}


@end
