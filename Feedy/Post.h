//
//  Post.h
//  Feedy
//
//  Created by Javier Rosas on 6/12/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface Post : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSURL *profilePicture;
@property (strong, nonatomic) Photo *photo;
@property (nonatomic) NSUInteger *likes;
@property (strong, nonatomic) NSString *caption;

- (instancetype)initWithPostData:(NSDictionary *)postData;

@end
