//
//  LoginViewController.m
//  carMax
//
//  Created by Yuhao Kan on 2017-07-18.
//  Copyright © 2017 Modiface Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"
#import "KeychainItemWrapper.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property NSString *alertTitle;
@property NSString *alertMsg;
@property BOOL alert;
- (IBAction)login:(id)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [_userName setDelegate:self];
    [_passWord setDelegate:self];
    _passWord.secureTextEntry = YES;
    self.alert = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)login:(id)sender {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:_userName.text accessGroup:nil];

    NSData *pwData = [keychainItem objectForKey:(__bridge id)kSecValueData];
    NSString *password = [[NSString alloc] initWithData:pwData encoding:NSUTF8StringEncoding];
    NSString *username = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    
    if ([_passWord.text isEqualToString:@""] || [_userName.text isEqualToString:@""]){
        
        self.alertTitle = @"Empty Credentials";
        self.alertMsg = @"Please enter both username and password";
        self.alert = YES;
    }
    
    else if ([password isEqualToString: _passWord.text] && [username isEqualToString: _userName.text]){
        ScheduleViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"SVC"];
        
        [self.navigationController pushViewController:svc animated:YES];
    }else{
        
        self.alertTitle = @"Wrong Credentials";
        self.alertMsg = @"Please try again";
        self.alert = YES;
        
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
