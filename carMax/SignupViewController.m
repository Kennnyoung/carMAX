//
//  SignupViewController.m
//  carMax
//
//  Created by Yuhao Kan on 2017-07-27.
//  Copyright © 2017 Modiface Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignupViewController.h"
#import "KeychainItemWrapper.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UIPickerView *status;
@property NSString *alertTitle;
@property NSString *alertMsg;
@property BOOL alert;
- (IBAction)registerUser:(id)sender;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [_userName setDelegate:self];
    [_passWord setDelegate:self];
    [_emailAddress setDelegate:self];
    _passWord.secureTextEntry = YES;
    self.alert = NO;
    
    self.status.delegate = self;
    self.status.dataSource = self;
    self.status.showsSelectionIndicator = YES;
    [self.view addSubview:self.status];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)dismissKeyboard {
    
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
    [_emailAddress resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 2;//Or, return as suitable for you...normally we use array for dynamic
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    switch(row) {
        case 0:
            title = @"Driver";
            break;
        case 1:
            title = @"Passenger";
            break;
        default:
            break;
    }
    return title;
}

//- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    
//    //Here, like the table view you can get the each section of each row if you've multiple sections
//    NSLog(@"Selected Color: %@. Index of selected color: %i", [arrayColors objectAtIndex:row], row);
//    
//    //Now, if you want to navigate then;
//    // Say, OtherViewController is the controller, where you want to navigate:
//    OtherViewController *objOtherViewController = [OtherViewController new];
//    [self.navigationController pushViewController:objOtherViewController animated:YES];
//    
//}



- (IBAction)registerUser:(id)sender {
    
    if (_userName.text.length < 5){
        
        self.alertTitle = @"Not Eough Username Characters";
        self.alertMsg = @"Username has to be at least 5 characters long";
        self.alert = YES;
    }
    
    else if (_passWord.text.length < 8){
        
        self.alertTitle = @"Not Eough Password Characters";
        self.alertMsg = @"Password has to be at least 8 characters long";
        self.alert = YES;
        
    }
    
    else {
    
        if (![_emailAddress.text containsString:@"@"]){
            
            self.alertTitle = @"Not Valid Email Address";
            self.alertMsg = @"Please enter a valid email";
            self.alert = YES;
            
        }
        
        else{
            
            KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:_userName.text accessGroup:nil];
            
            if ([[keychainItem objectForKey:(__bridge id)kSecAttrAccount] isEqualToString:_userName.text]){
                self.alertTitle = @"Existing Username";
                self.alertMsg = @"This username has been registered";
                self.alert = YES;
            }else{
                [keychainItem setObject:_passWord.text forKey:(__bridge id)kSecValueData];
                [keychainItem setObject:_userName.text forKey:(__bridge id)kSecAttrAccount];
                
                NSUserDefaults *emails = [NSUserDefaults standardUserDefaults];
                [emails setObject:_emailAddress.text forKey:[_userName.text stringByAppendingString:@" email"]];
                
                NSInteger row = [self.status selectedRowInComponent:0];
                
                NSUserDefaults *userStatus = [NSUserDefaults standardUserDefaults];
                
                if (row){
                    [userStatus setObject:@"passenger" forKey:[_userName.text stringByAppendingString:@" status"]];
                }else{
                    [userStatus setObject:@"driver" forKey:[_userName.text stringByAppendingString:@" status"]];
                }
                LoginViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                
                [self.navigationController pushViewController:lvc animated:YES];
            }
        }
    }
    
    
    if (self.alert){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:self.alertTitle
                                                                       message:self.alertMsg
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    
    self.alert = NO;
}
@end
