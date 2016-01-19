//
//  SongTableViewCell.m
//  Virtuoso
//
//  Created by sikander.m on 12/18/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "SongTableViewCell.h"
#import "PlaylistTracks.h"

@interface SongTableViewCell ()

//@property (weak, nonatomic) Playlist *selectedPlaylist;

@end

@implementation SongTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (IBAction)showOptions:(UIButton *)sender {
    
    [self.delegate optionsButtonClickedFromCell:self];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
