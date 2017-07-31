//
//  ScheduleViewController.m
//  carMax
//
//  Created by Yuhao Kan on 2017-07-27.
//  Copyright © 2017 Modiface Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleViewController.h"


@interface ScheduleViewController ()

@property (weak, nonatomic) IBOutlet UILabel *month;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    switch (month) {
        case 1:
            self.month.text = @"January";
            break;
        case 2:
            self.month.text = @"February";
            break;
        case 3:
            self.month.text = @"March";
            break;
        case 4:
            self.month.text = @"April";
            break;
        case 5:
            self.month.text = @"May";
            break;
        case 6:
            self.month.text = @"June";
            break;
        case 7:
            self.month.text = @"July";
            break;
        case 8:
            self.month.text = @"August";
            break;
        case 9:
            self.month.text = @"September";
            break;
        case 10:
            self.month.text = @"October";
            break;
        case 11:
            self.month.text = @"November";
            break;
        case 12:
            self.month.text = @"December";
        default:
            break;
    }
    
    NSLog(@"day: %lu, month: %lu, year: %lu\n", day, month, year);
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
