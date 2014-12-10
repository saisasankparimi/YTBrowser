//
//  searchController.h
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchController : UIViewController
{
    NSMutableArray* images;
     NSCache *_imageCache;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *theTable;

@property (nonatomic, strong) NSOperationQueue *queue;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBar;

-(void)yourButtonClicked:(UIButton*)sender;
@end
