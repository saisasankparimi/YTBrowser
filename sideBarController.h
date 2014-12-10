//
//  sideBarController.h
//  YTBrowser
//
//  Created by Admin on 9/25/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sideBarController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bottomTable;
@property (weak, nonatomic) IBOutlet UITableView *userTable;
- (UIImage*)loadImage;
@end
