//
//  VideoModel.h
//  YTBrowser
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//


#import "JSONModel.h"

#import "VideoLink.h"
#import "MediaThumbnail.h"

@protocol VideoModel @end



@interface VideoModel : JSONModel<NSCoding>

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSMutableArray<VideoLink>* link;
@property (strong, nonatomic) NSArray<MediaThumbnail>* thumbnail;
@end
