//
//  TableCell.m
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "TableCell.h"
#import "VideoModel.h"
@implementation TableCell

@synthesize languageLabel=_languageLabel;
@synthesize languageSwitch=_languageSwitch;
@synthesize planDescriptionLabel=_planDescriptionLabel ;
@synthesize planLabel=_planLabel;
@synthesize planKESLabel=_planKESLabel;
@synthesize thumbnailImage=_thumbnailImage;
@synthesize videoName=_videoName;

@synthesize BookmarkControllerImage=_BookmarkControllerImage;
- (IBAction)favBtnClicked:(id)sender {
//    NSDictionary *userInfo = @{@"rowSelected":[NSNumber numberWithInteger:_rowSelected]};
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"FavBtnClicked" object:self userInfo:userInfo];
    
  
    
    
    
}

@synthesize bookmarkControllerVideoName=_bookmarkControllerVideoName;
@end
