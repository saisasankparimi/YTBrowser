//
//  userInfoModel.m
//  YTBrowser
//
//  Created by Admin on 9/25/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "userInfoModel.h"

@implementation userInfoModel
@synthesize  userDictionary=_userDictionary;
+ (id)sharedManager {
    static userInfoModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        [self loadUserInfo];
    }
    return self;
}


-(void)addUserInfo:(NSArray *)arrays{

   _userDictionary = [[NSMutableDictionary alloc]init];

    [_userDictionary  setObject:arrays[0] forKey:@"name"];
    [_userDictionary  setObject:arrays[1] forKey:@"email"];
    [_userDictionary  setObject:arrays[2] forKey:@"location"];
    
    [self saveUserInfo:_userDictionary];
}

-(NSString *) getData:(NSString *)strings{

    return [_userDictionary valueForKey:strings];

}

-(void) saveUserInfo:(NSMutableDictionary *)dict{

    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"user"];
       [[NSUserDefaults standardUserDefaults] synchronize];

}


-(void) loadUserInfo{
    
    _userDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];

}
@end
