//
//  bookmarkController.h
//  YTBrowser
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bookmarkController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bookmarkTableView;
@property (weak, nonatomic) NSMutableArray* eleArray;
- (id)loadPhotoFromURL:(NSURL*)url;
@end
