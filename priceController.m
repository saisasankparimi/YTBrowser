//
//  priceController.m
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "priceController.h"
#import "planModel.h"
#import "TableCell.h"

@implementation priceController{
    planModel *plan;
}

@synthesize backgroundImage=_backgroundImage;


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image= [UIImage imageNamed:@"wallpaper.png"];
    _backgroundImage.image=image;
    
       plan=[[planModel alloc]init];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    
    return [[plan planName] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"priceIdentifier";

    
   TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    cell.planLabel.text = [[plan planName] objectAtIndex:indexPath.row];
    cell.planDescriptionLabel.text=[[plan planDescription] objectAtIndex:indexPath.row];
    cell.planKESLabel.text=[[plan planKES] objectAtIndex:indexPath.row];
    return cell;
}


@end
