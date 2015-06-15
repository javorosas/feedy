//
//  InstagramService.h
//  Feedy
//
//  Created by Javier Rosas on 6/15/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface InstagramService : NSObject

+(instancetype)sharedInstance;

- (void)getPostsWithTag:(NSString *)tag
               maxTagId:(NSString *)maxTagId
               minTagId:(NSString *)minTagId
                success:(void (^)(NSString *minTagId, NSString *maxTagId, NSArray *posts))success
                failure:(void (^)(NSError *error))failure;

@end
