//
//  AlbumInfoCell.h
//  Virtuoso
//
//  Created by sikander.m on 10/27/15.
//  Copyright (c) 2015 sikander.m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *albumArtistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumYearLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumArtworkImageView;
@end
