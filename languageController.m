//
//  languageController.m
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "languageController.h"


@implementation languageController{

    NSArray *languageTable;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    
    UIImage *image1 = [UIImage imageNamed:@"wallpaper.png"];
    _languageImage.image = image1;
    
    languageTable =[NSMutableArray arrayWithObjects:@"Afrikaans",@"English",@"Hindi",@"Zulu", nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [languageTable count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"langugaeIdentifier";
    
    TableCell *cell =(TableCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    cell.languageLabel.text = [languageTable objectAtIndex:indexPath.row];
    return cell;
    
}



@end
