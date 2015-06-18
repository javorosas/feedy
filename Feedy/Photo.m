//
//  Photo.m
//  Feedy
//
//  Created by Javier Rosas on 6/12/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithPhotoData:(NSDictionary *)photoData
{
    self = [super init];
    if (self) {
        NSDictionary *images = photoData[@"images"];
        self.lowres = [NSURL URLWithString:images[@"low_resolution"][@"url"]];
        self.highres = [NSURL URLWithString:images[@"standard_resolution"][@"url"]];
        self.thumbnail = [NSURL URLWithString:images[@"thumbnail"][@"url"]];
    }
    return self;
}

@end
