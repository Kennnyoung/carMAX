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
            
            [keychainItem setObject:_passWord.text forKey:(__bridge id)kSecValueData];
            [keychainItem setObject:_userName.text forKey:(__bridge id)kSecAttrAccount];
            
            NSUserDefaults *emails = [NSUserDefaults standardUserDefaults];
            [emails setObject:_emailAddress.text forKey:_userName.text];
            
            LoginViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
            
            [self.navigationController pushViewController:lvc animated:YES];
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
