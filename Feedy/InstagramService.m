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
    NSString *url = [NSString stringWithFormat:@"%@%@/media/recent", self.baseUrl, @"tags"];
    NSDictionary *parameters = @{
                                 @"client_id": self.clientId,
                                 @"max_tag_id": maxTagId,
                                 @"min_tag_id": minTagId
                                  };
    [self.afnManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        NSDictionary *pagination = response[@"pagination"];
        NSString *minTagId = pagination[@"min_tag_id"];
        NSString *maxTagId = pagination[@"next_max_tag_id"];
        NSArray *data = response[@"data"];
        NSMutableArray *posts;
        for (NSDictionary *postData in data) {
            NSDictionary *user = postData[@"user"];
            NSDictionary *photoData = postData[@"images"];
            Photo *photo = [[Photo alloc] init];
            photo.lowres = [NSURL URLWithString:photoData[@"low_resolution"]];
            photo.thumbnail = [NSURL URLWithString:photoData[@"thumbnail"]];
            photo.highres = [NSURL URLWithString:photoData[@"standard_resolution"]];
            
            Post *post = [[Post alloc] init];
            post.userId = user[@"id"];
            post.username = user[@"username"];
            post.profilePicture = [NSURL URLWithString:photoData[@"profile_picture"]];
            post.photo = photo;
            post.likes = (NSUInteger *)[postData[@"likes"][@"count"] integerValue];
            post.caption = postData[@"caption"][@"text"];
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

@end
