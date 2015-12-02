//
//  YTResultsViewController.m
//  Virtuoso
//
//  Created by sikander.m on 12/1/15.
//  Copyright © 2015 sikander.m. All rights reserved.
//

#import "YTResultsViewController.h"
#import "AFNetworking.h"
#import "YTPlayerViewController.h"

#define API_KEY @"AIzaSyAfV2EiADOBOOfYozL2XrPa2UfGb1YOqXw"

@interface YTResultsViewController ()

@end

@implementation YTResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *baseURL = @"https://www.googleapis.com/youtube/v3/";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"snippet" forKey:@"part"];
    [parameters setObject:@"5" forKey:@"maxResults"];
    //[parameters setObject:@"viewCount" forKey:@"order"];
    [parameters setObject:self.queryString forKey:@"q"];
    [parameters setObject:@"video" forKey:@"type"];
    [parameters setObject:API_KEY forKey:@"key"];
    [manager GET:[NSString stringWithFormat:@"%@search", baseURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        self.results = responseObject;
        //NSLog(@"%@", responseObject);
        self.title = @"Youtube Results";
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YT Result Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    //NSLog(@"%lu", [indexPath row]);
    NSArray *results = [self.results objectForKey:@"items"];
    //NSLog(@"%@", results);
    NSString *thumbnailURLString = [[[[results[[indexPath row]] objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"default"] objectForKey:@"url"];
    //NSLog(@"thumbnailURLString = %@", thumbnailURLString);
    NSString *videoTitle = [[results[[indexPath row]] objectForKey:@"snippet"] objectForKey:@"title"];
    NSString *videoChannelTitle = [[results[[indexPath row]] objectForKey:@"snippet"] objectForKey:@"channelTitle"];
    //NSLog(@"video and channel - %@ - %@", videoTitle, videoChannelTitle);
    NSURL *thumbnailURL = [NSURL URLWithString:thumbnailURLString];
    //NSLog(@"%@", thumbnailURL);
    NSData *thumbnailData = [NSData dataWithContentsOfURL:thumbnailURL];
    //NSLog(@"%@", thumbnailData);
    UIImage *thumbnail = [[UIImage alloc] initWithData:thumbnailData];
    cell.imageView.image = thumbnail;
    cell.textLabel.text = videoTitle;
    cell.detailTextLabel.text = videoChannelTitle;
    //NSLog(@"cell prepared - %lu", [indexPath row]);
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"YT Player Segue"]) {
        NSArray *results = [self.results objectForKey:@"items"];
        YTPlayerViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.videoID = [[results[[[self.tableView indexPathForSelectedRow] row]] objectForKey:@"id"] objectForKey:@"videoId"];
    }
    
}

@end
