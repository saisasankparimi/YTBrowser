//
//  TableCell.h
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UISwitch *languageSwitch;
@property (weak, nonatomic) IBOutlet UILabel *planLabel;
@property (weak, nonatomic) IBOutlet UILabel *planKESLabel;
@property (weak, nonatomic) IBOutlet UILabel *planDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UIImageView *BookmarkControllerImage;
@property (weak, nonatomic) IBOutlet UILabel *bookmarkControllerVideoName;
@property (nonatomic) NSInteger rowSelected;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;
@property (weak, nonatomic) IBOutlet UIButton *videoDetailButton;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic) IBOutlet UIImageView *profileImage;
@property (nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic) IBOutlet UILabel *nameLabel;


@end
