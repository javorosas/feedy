//
//  InstagramService.m
//  Feedy
//
//  Created by Javier Rosas on 6/15/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import "InstagramService.h"
#import <AFNetworking/AFNetworking.h>
#import "Feed.h"

@interface InstagramService()

@property AFHTTPRequestOperationManager *afnManager;
@property NSString *baseUrl;
@property NSString *clientId;

@end

@implementation InstagramService

+ (instancetype)sharedInstance {
    static InstagramService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[InstagramService alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.afnManager = [AFHTTPRequestOperationManager manager];
        self.baseUrl = @"https://api.instagram.com/v1/";
        self.clientId = @"742d91e2ed0e4a659f2d5b3c69449029";
    }
    return self;
}

- (void)getPostsWithTag:(NSString *)tag
               maxTagId:(NSString *)maxTagId
               minTagId:(NSString *)minTagId
                success:(void (^)(NSString *, NSString *, NSArray *))success
                failure:(void (^)(NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"%@tags/%@/media/recent", self.baseUrl, tag];
    NSLog(@"%@", url);
    NSDictionary *parameters;
    if (!maxTagId && !minTagId) {
        parameters = @{ @"client_id": self.clientId };
    } else if (maxTagId) {
        parameters = @{ @"client_id": self.clientId, @"max_tag_id": maxTagId };
    } else {
        parameters = @{ @"client_id": self.clientId, @"min_tag_id": minTagId };
    }
    [self.afnManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        NSDictionary *pagination = response[@"pagination"];
        NSString *minTagId = pagination[@"min_tag_id"];
        NSString *maxTagId = pagination[@"next_max_tag_id"];
        NSArray *data = response[@"data"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postData in data) {
            Post *post = [[Post alloc] initWithPostData:postData];
            [posts addObject:post];
        }
        if (success) {
            success(minTagId, maxTagId, [posts copy]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getGalleryWithUserId:(NSString *)userId
                       maxId:(NSString *)maxId
                     success:(void (^)(NSString *, NSArray *))success
                     failure:(void (^)(NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"%@users/%@/media/recent", self.baseUrl, userId];
    NSDictionary *parameters;
    if (maxId) {
        parameters = @{ @"client_id": self.clientId, @"max_id": maxId };
    } else {
        parameters = @{ @"client_id": self.clientId };
    }
    [self.afnManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        NSMutableArray *photos = [NSMutableArray array];
        for (NSDictionary *photoData in response[@"data"]) {
            [photos addObject:[[Photo alloc] initWithPhotoData:photoData]];
        }
        NSString *maxId = response[@"pagination"][@"next_max_id"];
        if (success) {
            success(maxId, [photos copy]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
