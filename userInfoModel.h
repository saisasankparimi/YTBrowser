//
//  userInfoModel.h
//  YTBrowser
//
//  Created by Admin on 9/25/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userInfoModel : NSObject{
 NSDictionary *userDictionary;
}



@property (strong, nonatomic) NSMutableDictionary *userDictionary;

+ (id)sharedManager;

-(void)addUserInfo:(NSArray *)array;
-(NSString *) getData:(NSString *)strings;
@end
