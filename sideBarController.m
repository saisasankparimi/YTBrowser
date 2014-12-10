//
//  sideBarController.m
//  YTBrowser
//
//  Created by Admin on 9/25/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "sideBarController.h"
#import "userInfoModel.h"
#import "TableCell.h"
@interface sideBarController ()
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation sideBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
 
    
    _menuItems = @[@"maps",@"bookmarks",@"calendar"];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [_userTable reloadData];
    [_bottomTable reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _userTable){
        return 1;}
    else{
        return [_menuItems count];
    
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"info";
    if(tableView == _userTable){
     userInfoModel *user = [userInfoModel sharedManager];
    
    TableCell *cell =(TableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    
    
    cell.nameLabel.text=[user getData:@"name"];
    
    cell.locationLabel.text = [user getData:@"location"];
   
        cell.profileImage.image = [self loadImage];
    return cell;
    }
    
    else{
       NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    
        UITableViewCell *cell = [_bottomTable dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
       
       return cell;
}

    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_userTable) {
         return 157;
    }
   else
   {
       return 44;
   }
}

- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"test.png" ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}

@end
