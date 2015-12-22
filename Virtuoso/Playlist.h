//
//  Playlist.h
//  Virtuoso
//
//  Created by sikander.m on 12/11/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Playlist : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (BOOL)checkIfPlaylistWithName:(NSString *)playlistName existsInManagedObjectContext:(NSManagedObjectContext *)context;

+ (BOOL)addNewPlaylistWithName:(NSString *)playlistName inManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Playlist+CoreDataProperties.h"
