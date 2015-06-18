//
//  ProfileHeaderController.h
//  Feedy
//
//  Created by Javier Rosas on 6/17/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileHeaderController : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end
