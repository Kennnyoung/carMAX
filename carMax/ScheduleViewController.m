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

@property (weak, nonatomic) IBOutlet UISegmentedControl *monthOption;
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
@property NSInteger day;
@property NSInteger month;
@property NSInteger year;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    self.day = [components day];
    self.month = [components month];
    self.year = [components year];
    self.dateArray = [[NSArray alloc] initWithObjects:_first,_second,_third,_fourth,_fifth,_sixth,_seventh,_eighth,_ninth,_tenth,_eleventh,_twelfth,_thirteenth,_fourteenth,_fifteenth,_sixteenth,_seventeenth,_eighteenth,_ninteenth,_twentyth,_twentyFirst,_twentySecond,_twentyThird,_twentyFourth,_twentyFifth,_twenthSixth,_twentySeventh,_twentyEighth,_twentyNinth,_thirtyth,_thirtyFirst,nil];
    switch (self.month) {
        case 1:
            [self.monthOption setTitle:@"January" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"February" forSegmentAtIndex:1];
            break;
        case 2:
            [self.monthOption setTitle:@"February" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"March" forSegmentAtIndex:1];
            break;
        case 3:
            [self.monthOption setTitle:@"March" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"April" forSegmentAtIndex:1];
            break;
        case 4:
            [self.monthOption setTitle:@"April" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"May" forSegmentAtIndex:1];
            break;
        case 5:
            [self.monthOption setTitle:@"May" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"June" forSegmentAtIndex:1];
            break;
        case 6:
            [self.monthOption setTitle:@"June" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"July" forSegmentAtIndex:1];
            break;
        case 7:
            [self.monthOption setTitle:@"July" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"August" forSegmentAtIndex:1];
            break;
        case 8:
            [self.monthOption setTitle:@"August" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"September" forSegmentAtIndex:1];
            break;
        case 9:
            [self.monthOption setTitle:@"September" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"October" forSegmentAtIndex:1];
            break;
        case 10:
            [self.monthOption setTitle:@"October" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"November" forSegmentAtIndex:1];
            break;
        case 11:
            [self.monthOption setTitle:@"November" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"December" forSegmentAtIndex:1];
            break;
        case 12:
            [self.monthOption setTitle:@"December" forSegmentAtIndex:0];
            [self.monthOption setTitle:@"January" forSegmentAtIndex:1];
        default:
            break;
    }
    
    for (int i =0; i< self.day-1;i++){
        UIButton *disable = [self.dateArray objectAtIndex:i];
        disable.enabled = NO;
    }
    
    [self.monthOption addTarget:self
                         action:@selector(displayValidDays:)
               forControlEvents:UIControlEventValueChanged];
   
}

- (void)displayValidDays:(id)sender{
    if (self.monthOption.selectedSegmentIndex == 0){
        [self displayOption:NO];
    }else{
        [self displayOption:YES];
    }

}

- (void)displayOption:(BOOL)valid{
   
    for (int i =0; i< self.day-1;i++){
        UIButton *disable = [self.dateArray objectAtIndex:i];
        disable.enabled = valid;
    }
   
    for (int i = 28; i < 31;i++){
        UIButton *displayButton = [self.dateArray objectAtIndex:i];
        displayButton.hidden = NO;
    }
    NSInteger validMonth = self.month + self.monthOption.selectedSegmentIndex;
    if (validMonth == 2 || validMonth == 4 || validMonth == 6 || validMonth == 9 || validMonth == 11){
        if (validMonth == 2){
            if (self.year % 4 != 0){
                UIButton *twentyNine = [self.dateArray objectAtIndex:28];
                twentyNine.hidden = YES;
            }
            UIButton *thirty = [self.dateArray objectAtIndex:29];
            thirty.hidden = YES;
        }
        UIButton *thirtyOne = [self.dateArray objectAtIndex:30];
        thirtyOne.hidden = YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
