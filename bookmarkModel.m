//
//  bookmarkModel.m
//  YTBrowser
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "bookmarkModel.h"
#import "VideoLink.h"
#import "MediaThumbnail.h"
@interface bookmarkModel() {

  }

@end

NSString * const key = @"key";

@implementation bookmarkModel
@synthesize  bookmark=_bookmark;

NSInteger i;





-(void)saveData
{
    
   
      NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_bookmark];
   [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"books"];
    [[NSUserDefaults standardUserDefaults] setObject:thumbnailUrls forKey:@"thumbnailKey"];
    
    [[NSUserDefaults standardUserDefaults] setObject:urlStrings forKey:@"urlKey"];
    NSLog (@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"books"]);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
//    NSMutableArray* archiveArray = [[NSMutableArray alloc] initWithArray:_bookmark];
//    
//    for (VideoModel *model in _bookmark) {
//        
//        // The error occurs on the line below
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//        [archiveArray addObject:data];
//    }
//    
//    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
//    [userData setObject:archiveArray forKey:key];
}




-(void)loadData{

    if (!_bookmark) {
        _bookmark =(NSMutableArray<VideoModel> *)[[NSMutableArray alloc] init];
    }
    
    NSData *data;
   //NSMutableArray *unArchivedArray;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"books"])
    {
    
        data = [[NSUserDefaults standardUserDefaults] objectForKey:@"books"];
        NSLog (@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"books"]);
        
        _bookmark = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        urlStrings = [[NSMutableArray alloc] init];
        thumbnailUrls = [[NSMutableArray alloc] init];
        urlStrings = [[NSUserDefaults standardUserDefaults] objectForKey:@"urlKey"];
        thumbnailUrls = [[NSUserDefaults standardUserDefaults] objectForKey:@"thumbnailKey"];
        
//        data = [[NSUserDefaults standardUserDefaults] objectForKey:@"books"];
//        
//          unArchivedArray =[NSKeyedUnarchiver unarchiveObjectWithData:data];
//        
//        for(int i=0; i<unArchivedArray.count;i++){
//        
////            _bookmark[i] = unArchivedArray[i];
//            [_bookmark addObject:unArchivedArray[i]];
//            
//        }
        
    }
    else
    {
        data = NULL;
        _bookmark = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
    }

}


+ (id)sharedManager {
    static bookmarkModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        [self loadData];
    }
    return self;
}




-(NSInteger) numberOfObjects{
   
  
    return _bookmark.count;
   NSLog(@"%lu",(unsigned long)_bookmark.count);
 
}

-(void) addObjects:(VideoModel *)videoObj{
    if (!_bookmark) {
        _bookmark =(NSMutableArray<VideoModel> *)[[NSMutableArray alloc] init];
        urlStrings = [[NSMutableArray alloc] init];
        thumbnailUrls =[[NSMutableArray alloc] init];
    }
    VideoLink* link = videoObj.link[0];
    MediaThumbnail *mediaLink = videoObj.thumbnail[0];
    [urlStrings addObject:[link.href absoluteString]];
    [thumbnailUrls addObject:[mediaLink.url absoluteString]];
    [_bookmark addObject:videoObj];
    [self saveData];
}

-(id) returnObjects{


    return _bookmark;
}

-(NSString *) returnTitle:(NSInteger)i{
    
    
    VideoModel *model = _bookmark[i];
    return model.title;

}

-(NSURL *) returnUrl:(NSInteger)i{

    VideoModel *model =  _bookmark[i];
    MediaThumbnail *url = model.thumbnail[0];
    
       return [NSURL URLWithString:thumbnailUrls[i]];
    
}


-(VideoModel *) objectAtIndex:(NSInteger)i{

   return _bookmark[i];
    
}

-(NSInteger) isObjectPresent:(VideoModel *)video{

    for(i=0;i<[self numberOfObjects];i++){
    
        if(_bookmark[i] == video){
            return 1;
        }
    
    }
    
    return 0;
}



@end
