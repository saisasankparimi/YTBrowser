//
//  personalInfoController.m
//  YTBrowser
//
//  Created by Admin on 9/24/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "personalInfoController.h"
#import "userInfoModel.h"
@interface personalInfoController ()
@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation personalInfoController{

    BOOL toogleValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_scroller setScrollEnabled:YES];
    [_scroller setContentSize:CGSizeMake(320, 800)];
    _menuItems = @[@"takePhoto",@"selectPhoto"];
    
    [_toggleTable reloadData];
    
    toogleValue = true;
     _toggleTable.hidden = true;
        
    }

-(void)fillFields{

    userInfoModel *user = [userInfoModel sharedManager];
    _nameField.text= [user.userDictionary valueForKey:@"name"];
    _emailField.text = [user.userDictionary valueForKey:@"email"];
        _locationField.text = [user.userDictionary valueForKey:@"location"];

}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //loading the image
    if([self loadImage]){
    _imageView.image = [self loadImage];
    }
    else{
    
        _imageView.image = [UIImage imageNamed:@"upload-photo.jpg"];
    }
    //fill all the text fields
    [self fillFields];
    
    //disabling the keyboard
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

-(void)dismissKeyboard {
    [_nameField resignFirstResponder];
    [_locationField resignFirstResponder];
    [_emailField resignFirstResponder];
}
- (IBAction)selectPhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (IBAction)toggleAction:(id)sender {
    if(toogleValue){
        _toggleTable.hidden = true;
    }
    else {
         _toggleTable.hidden = false;
    }
    toogleValue =!toogleValue;
    
    
}

- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
   
    //toggle action
    _toggleTable.hidden = true;
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self saveImageAction:_imageView.image];
      //toggle action
    _toggleTable.hidden = true;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
      //toggle action
    _toggleTable.hidden = true;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [_toggleTable dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}


- (IBAction)saveImage:(id)sender {
    
    [self saveImageAction:_imageView.image];
    
}


- (void)saveImageAction: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          @"test.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
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


- (IBAction)cancelAction:(id)sender {
    
    [self fillFields];
    
}

- (IBAction)addChangesAction:(id)sender {
    
    userInfoModel *user = [userInfoModel sharedManager];
    NSArray *array = [NSArray arrayWithObjects:_nameField.text,_emailField.text,_locationField.text,nil];
    
    [user addUserInfo:array];
    
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"User Info"
                                                    message:@"Your profile has been updated"
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    
    toast.transform = CGAffineTransformMakeTranslation(0.f, 0.f);
    [toast show];
    
    
    int duration = 1; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES]; });
    
}
@end


