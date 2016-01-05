//
//  PlaylistTracks+CoreDataProperties.h
//  Virtuoso
//
//  Created by sikander.m on 1/5/16.
//  Copyright © 2016 sikander.m. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PlaylistTracks.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaylistTracks (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *persistentId;
@property (nullable, nonatomic, retain) Playlist *playlist;

@end

NS_ASSUME_NONNULL_END
