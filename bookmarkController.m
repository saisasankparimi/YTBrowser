//
//  bookmarkController.m
//  YTBrowser
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "bookmarkController.h"
#import "bookmarkModel.h"
#import "TableCell.h"
#import "VideoModel.h"
#import "WebVideoViewController.h"
#import "VideoLink.h"
@implementation bookmarkController
@synthesize bookmarkTableView=_bookmarkTableView;

NSInteger i;


-(void) viewDidLoad{

      [self.bookmarkTableView reloadData];
    i=0;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   bookmarkModel *obj = [bookmarkModel sharedManager];
  //return [object numberOfObjects];
  //  NSLog(@"%lu , hello",(unsigned long)[obj numberOfObjects]);

    return  [obj numberOfObjects];
    NSLog(@"%ld",(long)[obj numberOfObjects]);
  }

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   bookmarkModel *obj = [bookmarkModel sharedManager];
 
    TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:@"bookmarkListIdentifier" forIndexPath:indexPath];
    VideoModel *model = [obj objectAtIndex:indexPath.row];
    cell.bookmarkControllerVideoName.text = model.title;
    
    
    NSURL *url =[obj returnUrl:indexPath.row];
    
    
cell.BookmarkControllerImage.image = [self loadPhotoFromURL:url];
    
    return cell;
}

- (id)loadPhotoFromURL:(NSURL*)url
{
    
    // fetch the remote photo
    NSData *data = [NSData dataWithContentsOfURL:url];
        
    
    // got the photo, so lets show it
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    bookmarkModel *obj = [bookmarkModel sharedManager];
    
    if ([segue.identifier isEqualToString:@"videoViewSegue"]) {
        NSIndexPath *indexPath = [self.bookmarkTableView indexPathForSelectedRow];
        WebVideoViewController* controller = segue.destinationViewController;
        VideoModel *model = [obj.bookmark objectAtIndex:indexPath.row];
       
        VideoLink* link = [VideoLink alloc];
        link.href = [NSURL URLWithString:obj->urlStrings[indexPath.row]];
        model.link =(NSMutableArray<VideoLink> *) [[NSMutableArray alloc] init];
        [model.link addObject:link];
        controller.video = model;
        
        NSLog(@" %lu",(unsigned long)indexPath.row);
        
    }
    


}



@end
