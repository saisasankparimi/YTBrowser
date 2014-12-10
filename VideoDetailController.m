//
//  VideoDetailController.m
//  YTBrowser
//
//  Created by Admin on 9/20/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "VideoDetailController.h"
#import "TableCell.h"
#import "bookmarkModel.h"
#import "JSONModelLib.h"
#import "XMLReader.h"


@interface VideoDetailController ()

@end

@implementation VideoDetailController

@synthesize model=_model;

- (void)viewDidLoad
{
   
 [super viewDidLoad];

    [_scroller setScrollEnabled:YES];
    [_scroller setContentSize:CGSizeMake(320, 1000)];

        //Video Name
    _videoName.text =_videoNameString;
        //Image
    imageURL = [NSURL URLWithString:_imageURLString];
    _videoImage.image = [self loadPhotoFromURL:imageURL];
    _commentsTable.delegate=self;
    
    
    VideoLink *link = _model.link[0];
    
    NSURL *url = link.href;
    
    NSString *urlString = [url absoluteString];
    
    [self downloadNeighbourCountries:[[self class] extractYoutubeID:urlString]];
    
}


+ (NSString *)extractYoutubeID:(NSString *)youtubeURL
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])];
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        NSString *substringForFirstMatch = [youtubeURL substringWithRange:rangeOfFirstMatch];
        
        return substringForFirstMatch;
    }
    return nil;
}



- (id) loadPhotoFromURL:(NSURL*)url
{
    
    // fetch the remote photo
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    
    // got the photo, so lets show it
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}





- (IBAction)addFavourites:(id)sender {
    
    bookmarkModel *obj = [bookmarkModel sharedManager];
    
    VideoModel* video =  _model;
    
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

-(void)yourButtonClicked:(UIButton*)sender
{
    
    bookmarkModel *obj = [bookmarkModel sharedManager];
    
    VideoModel* video =  _model;
    
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



-(void)downloadNeighbourCountries:(NSString *)apiURL{
    // Prepare the URL that we'll get the neighbour countries from.
    NSString *URLString = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@/comments?&start-index=1&max-results=20&v=2",apiURL];
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    // Download the data.
    [AppDelegate downloadDataFromURL:url withCompletionHandler:^(NSData *data) {
        // Make sure that there is data.
        if (data != nil) {
            self.xmlParser = [[NSXMLParser alloc] initWithData:data];
            self.xmlParser.delegate = self;
            
            // Initialize the mutable string that we'll use during parsing.
            self.foundValue = [[NSMutableString alloc] init];
            
            // Start parsing.
            [self.xmlParser parse];
        }
    }];
}


-(void)parserDidStartDocument:(NSXMLParser *)parser{
    // Initialize the neighbours data array.
    self.arrNeighboursData = [[NSMutableArray alloc] init];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    // When the parsing has been finished then simply reload the table view.
    [self.commentsTable reloadData];
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"ERROR :%@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    // If the current element name is equal to "geoname" then initialize the temporary dictionary.
    if ([elementName isEqualToString:@"entry"]) {
        self.dictTempDataStorage = [[NSMutableDictionary alloc] init];
    }
    
    // Keep the current element.
    self.currentElement = elementName;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"entry"]) {
        // If the closing element equals to "geoname" then the all the data of a neighbour country has been parsed and the dictionary should be added to the neighbours data array.
        [self.arrNeighboursData addObject:[[NSDictionary alloc] initWithDictionary:self.dictTempDataStorage]];
    }
    else if ([elementName isEqualToString:@"name"]){
        // If the country name element was found then store it.
        [self.dictTempDataStorage setObject:[NSString stringWithString:self.foundValue] forKey:@"name"];
    }
    else if ([elementName isEqualToString:@"content"]){
        // If the toponym name element was found then store it.
        [self.dictTempDataStorage setObject:[NSString stringWithString:self.foundValue] forKey:@"content"];
    }
    
    // Clear the mutable string.
    [self.foundValue setString:@""];
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    // Store the found characters if only we're interested in the current element.
    if ([self.currentElement isEqualToString:@"name"] ||
        [self.currentElement isEqualToString:@"content"]) {
        
        if (![string isEqualToString:@"\n"]) {
            [self.foundValue appendString:string];
        }
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrNeighboursData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[TableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    cell.titleLabel.text = [[self.arrNeighboursData objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.commentLabel.text = [[self.arrNeighboursData objectAtIndex:indexPath.row] objectForKey:@"content"];
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    //  Going to webVideoViewController
    
    
    if ([segue.identifier isEqualToString:@"videoViewSegue"]) {
        
        WebVideoViewController* controller = segue.destinationViewController;
        VideoModel* loan =  _model;
        controller.video=loan;
        
        
        
    }
}


    
    @end
