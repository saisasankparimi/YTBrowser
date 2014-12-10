//
//  VideoLink.h
//  YTBrowser
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "JSONModel.h"

@protocol VideoLink @end

@interface VideoLink : JSONModel<NSCoding>

@property (strong, nonatomic) NSURL* href;

@end