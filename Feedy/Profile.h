//
//  Profile.h
//  Feedy
//
//  Created by Javier Rosas on 6/12/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) NSURL *picture;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSStirng *website;

@end
