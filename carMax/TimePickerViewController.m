//
//  TimePickerViewController.m
//  carMax
//
//  Created by Yuhao Kan on 2017-08-14.
//  Copyright © 2017 Modiface Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimePickerViewController.h"
#import "Appdata.h"
#import "ScheduleViewController.h"

@interface TimePickerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *carBrand;
@property (weak, nonatomic) IBOutlet UITextField *carModel;
@property (weak, nonatomic) IBOutlet UITextField *driverAvailability;
@property (weak, nonatomic) IBOutlet UITextField *rate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)saveInfo:(id)sender;

@end

@implementation TimePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [_carBrand setDelegate:self];
    [_carModel setDelegate:self];
    [_driverAvailability setDelegate:self];
    [_rate setDelegate:self];
    
    self.scrollView.contentSize = CGSizeMake(414, 736);

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissKeyboard {
    
    [_carBrand resignFirstResponder];
    [_carModel resignFirstResponder];
    [_driverAvailability resignFirstResponder];
    [_rate resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)saveInfo:(id)sender {
    
    if ([_carBrand.text isEqualToString:@""] || [_carModel.text isEqualToString: @""] || [_driverAvailability.text isEqualToString: @""] || [_rate.text isEqualToString: @""]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Non empty text field"
                                                                       message:@"Any text field should not be left blank"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        ScheduleViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"SVC"];
        
        [self.navigationController pushViewController:svc animated:YES];
    
        
        
    }
    
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, _rate.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, _rate.frame.origin.y - keyboardSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
@end
