//
//  Profile.m
//  Feedy
//
//  Created by Javier Rosas on 6/12/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import "Profile.h"
#import "Post.h"
#import "InstagramService.h"

@interface Profile()

@property InstagramService *service;

@end

@implementation Profile

- (instancetype)initWithPost:(Post *)post {
    self = [super init];
    if (self) {
        self.userId = post.userId;
        self.picture = post.profilePicture;
        self.username = post.username;
        self.service = [InstagramService sharedInstance];
    }
    return self;
}

- (void)loadGalleryWithSuccessHandler:(void(^)(void))success failure:(void(^)(NSError *))failure {
    [self.service getGalleryWithUserId:self.userId maxId:nil success:^(NSString *maxId, NSArray *photos) {
        self.maxId = maxId;
        self.photos = photos;
        NSLog(@"%lu", photos.count);
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)loadMorePhotosWithSuccessHandler:(void(^)(void))success failure:(void(^)(NSError *))failure {
    [self.service getGalleryWithUserId:self.userId maxId:self.maxId success:^(NSString *maxId, NSArray *photos) {
        self.photos = [self.photos arrayByAddingObjectsFromArray:photos];
        self.maxId = maxId;
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

@end
