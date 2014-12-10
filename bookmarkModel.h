//
//  bookmarkModel.h
//  YTBrowser
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"
@interface bookmarkModel : NSObject {

    NSMutableArray<VideoModel> *bookmark;
    @public
    NSMutableArray * urlStrings;
    NSMutableArray *thumbnailUrls;
}

-(void)addObjects:(VideoModel *)videoObj;

-(id) returnObjects;

-(NSString *) returnTitle:(NSInteger)i;

-(NSInteger) numberOfObjects;

@property (nonatomic, strong) NSMutableArray<VideoModel> *bookmark;

+ (id)sharedManager;

-(NSURL *) returnUrl:(NSInteger)i;

-(bookmarkModel *) objectAtIndex:(NSInteger)i;
-(NSInteger) isObjectPresent:(VideoModel *)video;

-(void)saveData;
-(void)loadData;
@end
