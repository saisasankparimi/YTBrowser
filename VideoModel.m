//
//  VideoModel.m
//  YTBrowser
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//




#import "VideoModel.h"

@implementation VideoModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"media$group.media$thumbnail":@"thumbnail",
                                                       @"title.$t": @"title",
                                                       }];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [decoder decodeObjectForKey:@"title"];
   
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    }




@end
