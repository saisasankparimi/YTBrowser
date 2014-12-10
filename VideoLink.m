//
//  VideoLink.m
//  YTBrowser
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "VideoLink.h"

@implementation VideoLink


- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
   
    self.href = [decoder decodeObjectForKey:@"href"];
  
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
       [encoder encodeObject:self.href forKey:@"href"];
  }






@end
