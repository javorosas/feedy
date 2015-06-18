//
//  Profile.h
//  Feedy
//
//  Created by Javier Rosas on 6/12/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface Profile : NSObject

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSURL *picture;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSString *maxId;

- (instancetype)initWithPost:(Post *)post;
- (void)loadGalleryWithSuccessHandler:(void(^)(void))success failure:(void(^)(NSError *error))failure;
- (void)loadMorePhotosWithSuccessHandler:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end
