//
//  Feed.m
//  Feedy
//
//  Created by Javier Rosas on 6/15/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import "Feed.h"
#import "InstagramService.h"

@interface Feed()

@property InstagramService *service;
@property NSString *minTagId;
@property NSString *maxTagId;

@end

@implementation Feed

- (instancetype)initWithTag:(NSString *)tag success:(void(^)(void))success failure:(void(^)(NSError *))failure {
    self = [self init];
    _tag = tag;
    [self.service getPostsWithTag:self.tag maxTagId:nil minTagId:nil success:^(NSString *minTagId, NSString *maxTagId, NSArray *posts) {
        _posts = posts;
        self.maxTagId = maxTagId;
        self.minTagId = minTagId;
        if (success)
            success();
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [InstagramService sharedInstance];
    }
    return self;
}

- (void)loadNewerWithSuccessHandler:(void (^)(void))success failure:(void (^)(NSError *))failure {
    [self.service getPostsWithTag:self.tag maxTagId:self.maxTagId minTagId:nil success:^(NSString *minTagId, NSString *maxTagId, NSArray *posts) {
        self.maxTagId = maxTagId;
        // Place newer posts at the end of the array
        _posts = [self.posts arrayByAddingObjectsFromArray:posts];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)loadOlderWithSuccessHandler:(void (^)(void))success failure:(void (^)(NSError *))failure {
    [self.service getPostsWithTag:self.tag maxTagId:nil minTagId:self.minTagId success:^(NSString *minTagId, NSString *maxTagId, NSArray *posts) {
        _minTagId = minTagId;
        // Place older posts at the beginning of the array
        _posts = [posts arrayByAddingObjectsFromArray:self.posts];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
