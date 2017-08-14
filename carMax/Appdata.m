//
//  Appdata.m
//  carMax
//
//  Created by Yuhao Kan on 2017-08-14.
//  Copyright © 2017 Modiface Inc. All rights reserved.
//

#import "Appdata.h"

@implementation AppData
+(id)sharedData{
    
    static AppData *theData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theData = [[self alloc] init];
    });
    return theData;
    
}

-(id)init{
    if (self = [super init]) {
        /** initialize the selection data */
        self.currentUser = @"";
        self.currentMonth = @"";
        self.currentDay = @"";
    }
    
    return self;
}


@end
