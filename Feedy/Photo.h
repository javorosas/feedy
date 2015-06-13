//
//  Photo.h
//  Feedy
//
//  Created by Javier Rosas on 6/12/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSURL *highres;
@property (strong, nonatomic) NSURL *thumbnail;
@property (strong, nonatomic) NSURL *lowres;

@end
