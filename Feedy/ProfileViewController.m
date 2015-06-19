//
//  SecondViewController.m
//  Feedy
//
//  Created by Javier Rosas on 6/11/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import "ProfileViewController.h"
#import <UIImageView+WebCache.h>
#import <VPInteractiveImageView.h>
#import "PhotoCell.h"
#import "ProfileHeaderController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.profile loadMorePhotosWithSuccessHandler:^{
        NSLog(@"Loaded!");
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [self alertWithTitle:@"Error" message:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Count: %lu", self.profile.photos.count);
    return self.profile.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    Photo *photo = self.profile.photos[indexPath.row];
    [cell.photo sd_setImageWithURL:photo.thumbnail];
    cell.photoButton.tag = indexPath.row;
    if (indexPath.row >= self.profile.photos.count - 1) {
        [self loadMore];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ProfileHeaderController *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProfileHeader" forIndexPath:indexPath];
    header.usernameLabel.text = self.profile.username;
    [header.profilePictureView sd_setImageWithURL:self.profile.picture];
    return header;
}

- (void)loadMore {
    [self.profile loadMorePhotosWithSuccessHandler:^{
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [self alertWithTitle:@"Error" message:error.localizedDescription];
    }];
}

- (IBAction)photoClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    PhotoCell *cell = (PhotoCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0]];
    VPInteractiveImageView *interactiveImageView = [[VPInteractiveImageView alloc] initWithImage:cell.photo.image];
    [interactiveImageView presentFullscreen];
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

@end
