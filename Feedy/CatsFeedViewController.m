//
//  FirstViewController.m
//  Feedy
//
//  Created by Javier Rosas on 6/11/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import "CatsFeedViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "Feed.h"
#import "FeedCell.h"
#import "ProfileViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CatsFeedViewController ()

@property Feed *feed;

@end

@implementation CatsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    [self setUpRefresh];
//    self.tableView.bounces = YES;
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.feed = [[Feed alloc] initWithTag:@"cat" success:^{
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self alertWithTitle:@"Error" message:error.localizedDescription];
    }];
}

- (void)setUpRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor brownColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(loadNewer) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feed.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    
    Post *post = (Post *)self.feed.posts[indexPath.row];
    cell.username.text = post.username;
    cell.likes.text = [NSString stringWithFormat:@"Likes: %lu", (unsigned long)post.likes];
    cell.caption.text = post.caption;
    [cell.profilePicture sd_setImageWithURL:post.profilePicture];
    [cell.photo sd_setImageWithURL:post.photo.lowres];
    
    cell.profilePictureButton.tag = indexPath.row;
    
    if (indexPath.row >= self.feed.posts.count - 1) {
        [self loadOlder];
    }
    
    return cell;
}

- (IBAction)profilePictureClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    Post *post = self.feed.posts[button.tag];
    [self performSegueWithIdentifier:@"Profile" sender:post];
}


- (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    if ([UIAlertController class]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)loadNewer {
    [self.feed loadNewerWithSuccessHandler:^{
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(NSError *error) {
        [self alertWithTitle:@"Error" message:error.localizedDescription];
    }];
}

- (void)loadOlder {
    [self.feed loadOlderWithSuccessHandler:^{
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self alertWithTitle:@"Error" message:error.localizedDescription];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Post *post = (Post *)sender;
    ProfileViewController *profileViewController = (ProfileViewController *)segue.destinationViewController;
    Profile *profile = [[Profile alloc] init];
    profile.username = post.username;
    profile.picture = post.profilePicture;
    profile.userId = post.userId;
    
    profileViewController.profile = profile;
    
}

@end
