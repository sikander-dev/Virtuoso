//
//  PlaylistTracks.m
//  Virtuoso
//
//  Created by sikander.m on 12/11/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "PlaylistTracks.h"
#import "Playlist.h"

@implementation PlaylistTracks

// Insert code here to add functionality to your managed object subclass

+ (BOOL)checkIfPlaylistTrackWithPersistentId:(NSNumber *)persistentID existsInPlaylist:(Playlist *)playlist inManagedObjectContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PlaylistTracks"];
    request.predicate = [NSPredicate predicateWithFormat:@"persistentId = %@ && playlist = %@", persistentID, playlist];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if (!matches || error) {
        NSLog(@"Error = %@", error);
        return true;
    } else if ([matches count] > 1) {
        NSLog(@"Error in the database");
        return true;
    } else if ([matches count] == 1){
        return true;
    } else {
        return false;
    }
}

+ (void)addPlaylistTrackWithPersistentId:(NSNumber *)persistentId inPlaylist:(Playlist *)playlist inManagedObjectContext:(NSManagedObjectContext *)context {
    
    BOOL exists = [self checkIfPlaylistTrackWithPersistentId:persistentId existsInPlaylist:playlist inManagedObjectContext:context];
    if (!exists) {
        PlaylistTracks *playlistTrack = [NSEntityDescription insertNewObjectForEntityForName:@"PlaylistTracks" inManagedObjectContext:context];
        NSLog(@"persistentId = %@", persistentId);
        playlistTrack.persistentId = persistentId;
        playlistTrack.playlist = playlist;
    }
}

+ (NSUInteger)countTracksWithNullPlaylistInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PlaylistTracks"];
    request.predicate = [NSPredicate predicateWithFormat:@"playlist = nil"];
    NSArray *matches = [context executeFetchRequest:request error:nil];
    for (PlaylistTracks *playlistTrack in matches) {
        [context deleteObject:playlistTrack];
    }
    return matches.count;
}

@end
