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

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation YTResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Youtube Results";
    self.spinner.center = self.tableView.center;
    [self.tableView addSubview:self.spinner];
    [self.tableView bringSubviewToFront:self.spinner];
    [self.spinner startAnimating];
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
        self.results = [responseObject objectForKey:@"items"];
        //NSLog(@"%@", self.results);
        [self.spinner stopAnimating];
        if (self.results.count == 0) {
            [self showErrorAlertController];
        } else {
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed");
        [self.spinner stopAnimating];
        [self showErrorAlertController];
    }];
    
}

- (void)showErrorAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Youtube results could not be fetched." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
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
    return self.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YT Result Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *snippetObject = [self.results[[indexPath row]] objectForKey:@"snippet"];
    NSString *thumbnailURLString = [[[snippetObject objectForKey:@"thumbnails"] objectForKey:@"default"] objectForKey:@"url"];
    //NSLog(@"thumbnailURLString = %@", thumbnailURLString);
    NSString *videoTitle = [snippetObject objectForKey:@"title"];
    NSString *videoChannelTitle = [snippetObject objectForKey:@"channelTitle"];
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
        YTPlayerViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.videoID = [[self.results[[[self.tableView indexPathForSelectedRow] row]] objectForKey:@"id"] objectForKey:@"videoId"];
    }
    
}

@end
