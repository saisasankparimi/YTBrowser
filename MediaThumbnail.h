//
//  MediaThumbnail.h
//  YTBrowser
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "JSONModel.h"

@protocol MediaThumbnail @end

@interface MediaThumbnail : JSONModel<NSCoding>

@property (strong, nonatomic) NSURL* url;
@property (assign, nonatomic) int width;
@property (assign, nonatomic) int height;
@property (strong, nonatomic) NSString* time;

@end
