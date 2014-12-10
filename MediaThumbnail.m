//
//  MediaThumbnail.m
//  YTBrowser
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MediaThumbnail.h"

@implementation MediaThumbnail


- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.url = [decoder decodeObjectForKey:@"url"];
    self.time = [decoder decodeObjectForKey:@"time"];
    self.width = [decoder decodeIntegerForKey:@"width"];
    self.height = [decoder decodeIntegerForKey:@"height"];
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeInteger:self.width forKey:@"width"];
     [encoder encodeInteger:self.height forKey:@"height"];


}







@end
