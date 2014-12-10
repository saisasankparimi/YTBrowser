//
//  PhotoBox.h
//  YTBrowser
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MGBox.h"

@interface PhotoBox : MGBox

+(PhotoBox *)photoBoxForURL:(NSURL*)url title:(NSString*)title;

@property (strong, nonatomic) NSString* titleString;

@end
