//
//  homeController.m
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "homeController.h"



@implementation homeController

@synthesize tabImage1=_tabImage1;
@synthesize tabImage2=_tabImage2;



- (void)viewDidLoad
{
    [super viewDidLoad];
    _tabImage1.image=[UIImage imageNamed:@"red.png"];
    

}


- (IBAction)exploreButton:(id)sender {
    
    
    UIImage *image = [UIImage imageNamed:@"red.png"];
    
    _tabImage1.image=image;
    _tabImage2.image=NULL;
    
}

- (IBAction)myVideosButton:(id)sender {
    UIImage *image = [UIImage imageNamed:@"red.png"];
    
  _tabImage1.image=NULL;
    
    _tabImage2.image=image;

    
}







@end
