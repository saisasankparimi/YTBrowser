//
//  searchController.m
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "HUD.h"
#import "searchController.h"

#import "JSONModelLib.h"
#import "TableCell.h"
#import "MediaThumbnail.h"
#import "bookmarkModel.h"
#import "WebVideoViewController.h"
#import "VideoDetailController.h"
#import "bookmarkController.h"
#import "SWRevealViewController.h"
@interface searchController () <UISearchBarDelegate>{
    

    NSArray *videos;
  
    NSInteger i;
    
    NSMutableDictionary *imageCache;
    }
@end



@implementation searchController
@synthesize searchBar=_searchBar;
@synthesize sideBar=_sideBar;

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
     [self searchYoutubeVideosForTerm:searchString];
    return YES;
}


- (UIImage *)getCachedImage: (NSString*)url
{
    UIImage* theImage = [imageCache objectForKey:url];
    if ((nil != theImage) && [theImage isKindOfClass:[UIImage class]]) {
        return theImage;
    }
    else {
        theImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: url]]];
        [imageCache setObject:theImage forKey:url];
        return theImage;
    }
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
 [self searchYoutubeVideosForTerm:_searchBar.text];

}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    bookmarkController *viewController = (bookmarkController *)[storyboard instantiateViewControllerWithIdentifier:@"hello"];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void) viewDidLoad{

    [super viewDidLoad];
    _searchBar.delegate=self;
    _searchBar.placeholder =@"Search youtube ...";
    _searchBar.text=@"IPhone 6";
    _searchBar.showsBookmarkButton=YES;
    images =[[NSMutableArray alloc] init];
    [self searchYoutubeVideosForTerm: _searchBar.text];

    i=0;
    
    
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.maxConcurrentOperationCount = 10;

    _sideBar.target = self.revealViewController;
    _sideBar.action = @selector(revealToggle:);
    
    
    
    // Set the gesture
//[self.navigationController.view  addGestureRecognizer:self.revealViewController.panGestureRecognizer];

//    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(revealToggle:)];
//    [self.view addGestureRecognizer:gesture];
    
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [self searchYoutubeVideosForTerm:textField.text];
    return YES;
}


-(void)searchYoutubeVideosForTerm:(NSString*)term
{
    bookmarkModel *obj = [bookmarkModel sharedManager];
    //show loader view
    [HUD showUIBlockingIndicatorWithText:@"Fetching Videos"];
    
    NSLog(@"Searching for '%@' ...", term);
    
    //URL escape the term
    term = [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //make HTTP call
    NSString* searchCall = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?q=%@&max-results=15&alt=json", term];
   
    
    [JSONHTTPClient getJSONFromURLWithString: searchCall
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      
                                      //got JSON back
                                   //   NSLog(@"Got JSON from web: %@", json);
                                      
                                      if (err) {
                                          [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:[err localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Close"
                                                            otherButtonTitles: nil] show];
                                          return;
                                      }
                                      
                                      [HUD hideUIBlockingIndicator];
                                      
                                      
                                      //initialize the models
                                     videos = [VideoModel arrayOfModelsFromDictionaries:
                                                json[@"feed"][@"entry"]
                                                ];
                                      
                                      
                                      
                                      [self.theTable reloadData];
                                      
                                   //   [self saveImages];
                                  
                                  
                                  }];
}


- (id)loadPhotoFromURL:(NSURL*)url
{
    
    // fetch the remote photo
    NSData *data = [NSData dataWithContentsOfURL:url];
        // got the photo, so lets show it
        UIImage *image = [UIImage imageWithData:data];
    return image;
  }





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return videos.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel* loan =  videos[indexPath.row];
    MediaThumbnail *url = loan.thumbnail[0];
//
//   
//
//    
//    
//    TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:@"videoListIdentifier" forIndexPath:indexPath];
//    cell.videoName.text = [NSString stringWithFormat:@"%@",
//                           loan.title
//                           ];
//   // cell.rowSelected = indexPath.row;
//    cell.favouriteButton.tag = indexPath.row;
//    [cell.favouriteButton addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.videoDetailButton addTarget:self action:@selector(videoDetailClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //cell.thumbnailImage.image=[self loadPhotoFromURL:url.url];
//    
//    NSString *urlString = [url.url absoluteString];
//    
//     cell.thumbnailImage.image=[self getCachedImage:urlString];
//    return cell;


   TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:@"videoListIdentifier" forIndexPath:indexPath];
    
    
    
   
    
    cell.videoName.text = [NSString stringWithFormat:@"%@",loan.title];

        cell.favouriteButton.tag = indexPath.row;
       [cell.favouriteButton addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.videoDetailButton addTarget:self action:@selector(videoDetailClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    
    UIImage *image = [_imageCache objectForKey:cell.videoName];
    
    if (image)
    {
        
        cell.thumbnailImage.image = image;
    }
    else
    {
        cell.thumbnailImage.image = nil;
        
       
        
        [self.queue addOperationWithBlock:^{
            
          
            
            UIImage *image = [self loadPhotoFromURL:url.url];
            
            
            if (image)
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                   
                    
                    TableCell *cell = (TableCell *)[self.theTable cellForRowAtIndexPath:indexPath];
                    if (cell)
                        cell.thumbnailImage.image = image;
                }];
                
                [_imageCache setObject:image forKey:cell.videoName.text];
            }
        }];
    }
    
    return cell;









}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    //  Going to webVideoViewController
    
    
//    if ([segue.identifier isEqualToString:@"videoViewSegue"]) {
//        NSIndexPath *indexPath = [self.theTable indexPathForSelectedRow];
//        WebVideoViewController* controller = segue.destinationViewController;
//        VideoModel* loan =  videos[indexPath.row];
//        controller.video=loan;
//
//          NSLog(@" %lu",(unsigned long)indexPath.row);
//        
//    }

       if ([segue.identifier isEqualToString:@"VideoDetailIdentifier"]) {
          NSIndexPath *indexPath = [self.theTable indexPathForSelectedRow];
           VideoDetailController* controller = segue.destinationViewController;
          VideoModel* model =  videos[indexPath.row];
          
           controller.videoNameString = model.title;
           MediaThumbnail *media = model.thumbnail[0];
           
           controller.imageURLString =[media.url absoluteString];
              NSLog(@"%@",controller.imageURLString);
           
           controller.model = model;
           
       }
    
    
    
   }




-(void)yourButtonClicked:(UIButton*)sender
{
   
    bookmarkModel *obj = [bookmarkModel sharedManager];
   
    VideoModel* video =  videos[sender.tag];
   
    if([obj isObjectPresent:video]){
    
        
        NSString *message = [NSString stringWithFormat:@"This Video is already in your Favourites"];
        
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Favourites"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        
        toast.transform = CGAffineTransformMakeTranslation(0.f, 0.f);
        [toast show];
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });

        
    
    }
    else{
    
    
        NSLog(@" value of %ld",(long)[obj isObjectPresent:video]);
        
        
        [obj addObjects:video];
        
        NSString *message = [NSString stringWithFormat:@"%@ is added as your Favourites", video.title];
        
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Favourites"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        
        toast.transform = CGAffineTransformMakeTranslation(0.f, 0.f);
        [toast show];
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
        
        NSLog(@"%lu",(long)[obj numberOfObjects]);
    
    }
    
    
}

-(void)videoDetailClicked:(UIButton*)sender{
    
    VideoModel* video =  videos[sender.tag];
  
    
  

  
}



@end
