//
//  homeController.h
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *tabImage1;
@property (weak, nonatomic) IBOutlet UIImageView *tabImage2;

- (IBAction)exploreButton:(id)sender;

- (IBAction)myVideosButton:(id)sender;

@end
