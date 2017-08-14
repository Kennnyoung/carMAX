//
//  Appdata.h
//  carMax
//
//  Created by Yuhao Kan on 2017-08-14.
//  Copyright © 2017 Modiface Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Appdata_h
#define Appdata_h


#endif /* Appdata_h */

@interface AppData : NSObject
+ (AppData *)sharedData;

@property NSString *currentUser;
@property NSString *currentMonth;
@property NSString *currentDay;

@end
