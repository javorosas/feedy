//
//  Feed.h
//  Feedy
//
//  Created by Javier Rosas on 6/15/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface Feed : NSObject

@property (readonly, nonatomic) NSArray *posts;
@property (readonly, nonatomic) NSString *tag;

- (instancetype)initWithTag:(NSString *)tag success:(void(^)(void))success failure:(void(^)(NSError *error))failure;
- (void)loadOlderWithSuccessHandler:(void(^)(void))success failure:(void(^)(NSError *error))failure;
- (void)loadNewerWithSuccessHandler:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end
