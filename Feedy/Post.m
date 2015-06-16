//
//  Post.m
//  Feedy
//
//  Created by Javier Rosas on 6/12/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype)initWithPostData:(NSDictionary *)postData
{
    self = [super init];
    if (self) {
        NSDictionary *user = postData[@"user"];
        NSDictionary *photoData = postData[@"images"];
        Photo *photo = [[Photo alloc] init];
        photo.lowres = [NSURL URLWithString:photoData[@"low_resolution"][@"url"]];
        photo.thumbnail = [NSURL URLWithString:photoData[@"thumbnail"][@"url"]];
        photo.highres = [NSURL URLWithString:photoData[@"standard_resolution"][@"url"]];
        
        self.userId = user[@"id"];
        self.username = user[@"username"];
        self.profilePicture = [NSURL URLWithString:user[@"profile_picture"]];
        self.photo = photo;
        self.likes = (NSUInteger *)[postData[@"likes"][@"count"] integerValue];
        self.caption = postData[@"caption"][@"text"];
//        self.caption = @"You think water moves fast? You should see ice. It moves like it has a mind. Like it knows it killed the world once and got a taste for murder. After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. Nature is lethal but it doesn't hold a candle to man.";
    }
    return self;
}

@end
