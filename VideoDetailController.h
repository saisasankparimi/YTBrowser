//
//  VideoDetailController.h
//  YTBrowser
//
//  Created by Admin on 9/20/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "AppDelegate.h"
#import "TableCell.h"
#import "VideoLink.h"
#import "WebVideoViewController.h"
@interface VideoDetailController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>
{
    NSURL *imageURL;
}

@property (weak, nonatomic) IBOutlet UITableView *commentsTable;

@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;

@property (weak, nonatomic) IBOutlet UILabel *videoName;

@property  (weak, nonatomic) VideoModel *model;
- (IBAction)addFavourites:(id)sender;

-(void)yourButtonClicked:(UIButton*)sender;

@property (weak, nonatomic) NSString *videoNameString;
@property (weak, nonatomic) NSString *imageURLString;
//@property  (weak, nonatomic) NSURL *imageURL;



- (id) loadPhotoFromURL:(NSURL*)url;



@property (nonatomic, strong) NSXMLParser *xmlParser;

@property (nonatomic, strong) NSMutableArray *arrNeighboursData;

@property (nonatomic, strong) NSMutableDictionary *dictTempDataStorage;

@property (nonatomic, strong) NSMutableString *foundValue;

@property (nonatomic, strong) NSString *currentElement;


+ (NSString *) extractYoutubeID:(NSString *)youtubeURL;

@end
