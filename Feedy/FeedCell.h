//
//  FeedCell.h
//  Feedy
//
//  Created by Javier Rosas on 6/12/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *likes;
@property (weak, nonatomic) IBOutlet UITextView *caption;
@property (weak, nonatomic) IBOutlet UIButton *profilePictureButton;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@end
