//
//  Playlist+CoreDataProperties.h
//  Virtuoso
//
//  Created by sikander.m on 1/5/16.
//  Copyright © 2016 sikander.m. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Playlist.h"

@class PlaylistTracks;

NS_ASSUME_NONNULL_BEGIN

@interface Playlist (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<PlaylistTracks *> *tracks;

@end

@interface Playlist (CoreDataGeneratedAccessors)

- (void)addTracksObject:(PlaylistTracks *)value;
- (void)removeTracksObject:(PlaylistTracks *)value;
- (void)addTracks:(NSSet<PlaylistTracks *> *)values;
- (void)removeTracks:(NSSet<PlaylistTracks *> *)values;

@end

NS_ASSUME_NONNULL_END
