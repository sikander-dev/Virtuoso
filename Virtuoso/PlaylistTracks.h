//
//  PlaylistTracks.h
//  Virtuoso
//
//  Created by sikander.m on 12/11/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Playlist;

NS_ASSUME_NONNULL_BEGIN

@interface PlaylistTracks : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (BOOL)checkIfPlaylistTrackWithPersistentId:(NSString *)persistentID existsInPlaylist:(Playlist *)playlist inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)addPlaylistTrackWithPersistentId:(NSString *)persistentId inPlaylist:(Playlist *)playlist inManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "PlaylistTracks+CoreDataProperties.h"
