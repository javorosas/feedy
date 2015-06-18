//
//  SecondViewController.h
//  Feedy
//
//  Created by Javier Rosas on 6/11/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"

@interface ProfileViewController : UICollectionViewController

@property NSString *userId;
@property Profile *profile;

@end

