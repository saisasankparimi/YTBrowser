//
//  sideBarControllerTableViewController.m
//  YTBrowser
//
//  Created by Admin on 9/23/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "sideBarControllerTableViewController.h"
#import "userInfoModel.h"
#import "TableCell.h"
@interface sideBarControllerTableViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation sideBarControllerTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    
    _menuItems = @[@"maps",@"bookmarks",@"calendar"];
    [self.tableView registerClass:[TableCell class] forCellReuseIdentifier:@"info"];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    userInfoModel *user = [userInfoModel sharedManager];
    
    TableCell *cell = [[TableCell alloc]init];

    cell.nameLabel.text=[user getData:@"name"];
    
   cell.locationLabel.text = [user getData:@"location"];



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
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"info";
    
TableCell *cell =(TableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;

//    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
//    
//    UITableCell *cell = [_table dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    return cell;



}

@end
