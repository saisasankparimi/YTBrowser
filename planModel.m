//
//  planModel.m
//  YTBrowser
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "planModel.h"

@implementation planModel{

    NSMutableArray *planTable;
    NSMutableArray *descriptionTable;
    NSMutableArray *kesTable;
}


-(id) planName{

planTable = [NSMutableArray arrayWithObjects:@"Free 30 mins",@"Standard",@"Night Owl", nil];
    return planTable;
}

-(id) planDescription{

     descriptionTable =[NSMutableArray arrayWithObjects:@"blah blah blah",@"abc def ghi",@"qwerty uioty", nil];
    return descriptionTable;

}

-(id) planKES{

     kesTable = [NSMutableArray arrayWithObjects:@"0.00kes",@"10.00kes",@"25.00kes", nil];
    return kesTable;
}
@end
