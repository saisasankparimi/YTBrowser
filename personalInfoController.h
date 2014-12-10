//
//  personalInfoController.h
//  YTBrowser
//
//  Created by Admin on 9/24/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personalInfoController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;

- (IBAction)toggleAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *toggleTable;


@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
- (IBAction)saveImage:(id)sender;
- (UIImage*)loadImage;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UITextField *locationField;
- (IBAction)cancelAction:(id)sender;

- (IBAction)addChangesAction:(id)sender;

@end
