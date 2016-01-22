//
//  NowPlayingViewController.m
//  Virtuoso
//
//  Created by sikander.m on 10/30/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "NowPlayingViewController.h"
#import "PlaybackDurationToStringConverter.h"
#import "YTResultsViewController.h"

@interface NowPlayingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistAlbumLabel;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIView *volumeViewParentView;
@property (weak, nonatomic) IBOutlet UISlider *nowPlayingSlider;
@property (weak, nonatomic) IBOutlet UILabel *playbackDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPlaybackTimeLabel;
@end

@implementation NowPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.musicPlayer = [MPMusicPlayerController systemMusicPlayer];
    [self setupVolumeSlider];
    [self registerMediaPlayerNotifications];
}

- (void)setupVolumeSlider {
    
    self.volumeViewParentView.backgroundColor = [UIColor clearColor];
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:self.volumeViewParentView.bounds];
    [self.volumeViewParentView addSubview:volumeView];
    //[volumeView release];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self updatePlayPauseButton];
    
    [self updateArtwork];
    
    [self updateInfoLabels];
    
    [self updateCurrentPlaybackTime];
    
    [self updatePlaybackDuration];
    
}

- (void)updatePlaybackDuration {
    if (self.musicPlayer.nowPlayingItem) {
        NSNumber *songDuration = [self.musicPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration];
        self.playbackDurationLabel.text = [PlaybackDurationToStringConverter getStringFromPlaybackDuration:songDuration];
    }
    else {
        self.playbackDurationLabel.text = @"";
    }
}

- (void)updatePlayPauseButton {
    
    if ([self.musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        [self.playPauseButton setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
    } else {
        [self.playPauseButton setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
    }
}

- (void)updateArtwork {
    
    MPMediaItem *currentSong = [self.musicPlayer nowPlayingItem];
    UIImage *artworkImage = [[currentSong valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:self.artworkImageView.bounds.size];
    if (!artworkImage) {
        artworkImage = [UIImage imageNamed:@"No-artwork.png"];
    }
    [self.artworkImageView setImage:artworkImage];
    
}

- (void)updateInfoLabels {
    
    MPMediaItem *currentSong = [self.musicPlayer nowPlayingItem];
    NSString *songTitle = [currentSong valueForProperty:MPMediaItemPropertyTitle];
    if (!songTitle) {
        songTitle = @"Unknown title";
    }
    self.titleLabel.text = songTitle;
    NSString *artistAlbumLabelText;
    NSString *artistName = [currentSong valueForProperty:MPMediaItemPropertyArtist];
    if (!artistName) {
        artistName = @"";
    }
    artistAlbumLabelText = artistName;
    NSString *albumName = [currentSong valueForProperty:MPMediaItemPropertyAlbumTitle];
    if (!albumName) {
        albumName = @"";
    }
    if (![albumName isEqualToString:@""]) {
        artistAlbumLabelText = [artistAlbumLabelText stringByAppendingString:[NSString stringWithFormat:@"/%@", albumName]];
    }
    self.artistAlbumLabel.text = artistAlbumLabelText;
    //self.artistAlbumLabel.text = [NSString stringWithFormat:@"%@/%@", artistName, albumName];

}

- (void)updateCurrentPlaybackTime {
    if (self.musicPlayer.nowPlayingItem) {
        NSTimeInterval currentPlaybackTime = self.musicPlayer.currentPlaybackTime;
        NSTimeInterval songDuration = [[self.musicPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration] doubleValue];
        [self.nowPlayingSlider setValue:currentPlaybackTime/songDuration animated:YES];
    } else {
        [self.nowPlayingSlider setValue:0.0 animated:YES];
    }
}

- (void)registerMediaPlayerNotifications {
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(handleNowPlayingItemChanged:) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:self.musicPlayer];
    [notificationCenter addObserver:self selector:@selector(handlePlaybackStateChanged:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
    [self.musicPlayer beginGeneratingPlaybackNotifications];
}

- (void)handleNowPlayingItemChanged:(id)notification {
    
    [self updateArtwork];
    [self updateInfoLabels];
    [self updatePlaybackDuration];
}

- (void)handlePlaybackStateChanged:(id)notification {
    /*
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
    {
        if (self.musicPlayer.playbackState != MPMusicPlaybackStatePlaying) {
            [self setNSUserDefaults];
        }
    }
     */
    [self updatePlayPauseButton];
}

- (void)setNSUserDefaults {
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController systemMusicPlayer];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (musicPlayer.nowPlayingItem) {
        [defaults setObject:[musicPlayer.nowPlayingItem valueForKey:MPMediaEntityPropertyPersistentID] forKey:@"nowPlayingSongId"];
        [defaults setObject:[NSNumber numberWithInt:musicPlayer.currentPlaybackTime] forKey:@"currentPlaybackTime"];
        [defaults synchronize];
        NSLog(@"NSUserDefaults saved");
    } else {
        [defaults setObject:nil forKey:@"nowPlayingSongId"];
    }
}

- (IBAction)playPause:(UIButton *)sender {
    
    if ([self.musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        [self.musicPlayer pause];
    } else {
        [self.musicPlayer play];
    }
}

- (IBAction)previousSong:(UIButton *)sender {
    [self.musicPlayer skipToPreviousItem];
}

- (IBAction)nextSong:(UIButton *)sender {
    [self.musicPlayer skipToNextItem];
}
- (IBAction)currentPlaybackTimeChanged:(UISlider *)sender {
    if (self.musicPlayer.nowPlayingItem) {
        NSTimeInterval currentPlaybackTime = self.nowPlayingSlider.value * [[self.musicPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration] doubleValue];
        self.musicPlayer.currentPlaybackTime = currentPlaybackTime;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:self.musicPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
    [self.musicPlayer endGeneratingPlaybackNotifications];
}

- (IBAction)youtubeButtonPressed:(UIButton *)sender {
    
    if (self.musicPlayer.nowPlayingItem) {
        [self performSegueWithIdentifier:@"YT Results Segue" sender:sender];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"YT Results Segue"]) {
        YTResultsViewController *destinationViewController = [segue destinationViewController];
        MPMediaItem *currentSong = [self.musicPlayer nowPlayingItem];
        destinationViewController.queryString = [NSString stringWithFormat:@"%@ %@", [currentSong valueForProperty:MPMediaItemPropertyTitle], [currentSong valueForProperty:MPMediaItemPropertyArtist]];
    }
    
}

@end










