//
//  Playlist.m
//  Virtuoso
//
//  Created by sikander.m on 12/11/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist

// Insert code here to add functionality to your managed object subclass

+ (BOOL)checkIfPlaylistWithName:(NSString *)playlistName existsInManagedObjectContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Playlist"];
    request.predicate = [NSPredicate predicateWithFormat:@"name =[c] %@", playlistName];
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

+ (BOOL)addNewPlaylistWithName:(NSString *)playlistName inManagedObjectContext:(NSManagedObjectContext *)context {
    
    BOOL exists = [Playlist checkIfPlaylistWithName:playlistName existsInManagedObjectContext:context];
    if (exists) {
        return false;
    } else {
        Playlist *playlist = [NSEntityDescription insertNewObjectForEntityForName:@"Playlist" inManagedObjectContext:context];
        playlist.name = playlistName;
        return true;
    }
}

@end
