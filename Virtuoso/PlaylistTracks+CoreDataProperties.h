//
//  PlaylistTracks+CoreDataProperties.h
//  Virtuoso
//
//  Created by sikander.m on 12/11/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PlaylistTracks.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaylistTracks (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *persistentId;
@property (nullable, nonatomic, retain) Playlist *playlist;

@end

NS_ASSUME_NONNULL_END
