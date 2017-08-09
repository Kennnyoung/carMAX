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
@property (weak, nonatomic) IBOutlet UIButton *first;
@property (weak, nonatomic) IBOutlet UIButton *second;
@property (weak, nonatomic) IBOutlet UIButton *third;
@property (weak, nonatomic) IBOutlet UIButton *fourth;
@property (weak, nonatomic) IBOutlet UIButton *fifth;
@property (weak, nonatomic) IBOutlet UIButton *sixth;
@property (weak, nonatomic) IBOutlet UIButton *seventh;
@property (weak, nonatomic) IBOutlet UIButton *eighth;
@property (weak, nonatomic) IBOutlet UIButton *ninth;
@property (weak, nonatomic) IBOutlet UIButton *tenth;
@property (weak, nonatomic) IBOutlet UIButton *eleventh;
@property (weak, nonatomic) IBOutlet UIButton *twelfth;
@property (weak, nonatomic) IBOutlet UIButton *thirteenth;
@property (weak, nonatomic) IBOutlet UIButton *fourteenth;
@property (weak, nonatomic) IBOutlet UIButton *fifteenth;
@property (weak, nonatomic) IBOutlet UIButton *sixteenth;
@property (weak, nonatomic) IBOutlet UIButton *seventeenth;
@property (weak, nonatomic) IBOutlet UIButton *eighteenth;
@property (weak, nonatomic) IBOutlet UIButton *ninteenth;
@property (weak, nonatomic) IBOutlet UIButton *twentyth;
@property (weak, nonatomic) IBOutlet UIButton *twentyFirst;
@property (weak, nonatomic) IBOutlet UIButton *twentySecond;
@property (weak, nonatomic) IBOutlet UIButton *twentyThird;
@property (weak, nonatomic) IBOutlet UIButton *twentyFourth;
@property (weak, nonatomic) IBOutlet UIButton *twentyFifth;
@property (weak, nonatomic) IBOutlet UIButton *twenthSixth;
@property (weak, nonatomic) IBOutlet UIButton *twentySeventh;
@property (weak, nonatomic) IBOutlet UIButton *twentyEighth;
@property (weak, nonatomic) IBOutlet UIButton *twentyNinth;
@property (weak, nonatomic) IBOutlet UIButton *thirtyth;
@property (weak, nonatomic) IBOutlet UIButton *thirtyFirst;
@property NSArray *dateArray;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    self.dateArray = [[NSArray alloc] initWithObjects:_first,_second,_third,_fourth,_fifth,_sixth,_seventh,_eighth,_ninth,_tenth,_eleventh,_twelfth,_thirteenth,_fourteenth,_fifteenth,_sixteenth,_seventeenth,_eighteenth,_ninteenth,_twentyth,_twentyFirst,_twentySecond,_twentyThird,_twentyFourth,_twentyFifth,_twenthSixth,_twentySeventh,_twentyEighth,_twentyNinth,_thirtyth,_thirtyFirst,nil];
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
    
    for (int i =0; i< day-1;i++){
        UIButton *disable = [self.dateArray objectAtIndex:i];
        disable.enabled = NO;
    }
    
    if (month == 2 || month == 4 || month == 6 || month == 9 || month == 11){
        if (month == 2){
            if (year % 4 != 0){
                UIButton *twentyNine = [self.dateArray objectAtIndex:28];
                twentyNine.hidden = YES;
            }
            UIButton *thirty = [self.dateArray objectAtIndex:29];
            thirty.hidden = YES;
        }
        UIButton *thirtyOne = [self.dateArray objectAtIndex:30];
        thirtyOne.hidden = YES;
    }
    
    NSLog(@"day: %lu, month: %lu, year: %lu\n", day, month, year);
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
