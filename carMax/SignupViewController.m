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
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:_userName.text accessGroup:nil];
    
    [keychainItem setObject:_passWord.text forKey:(__bridge id)kSecValueData];
    [keychainItem setObject:_userName.text forKey:(__bridge id)kSecAttrAccount];
    
    NSUserDefaults *emails = [NSUserDefaults standardUserDefaults];
    [emails setObject:_emailAddress.text forKey:_userName.text];
    
    LoginViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [self.navigationController pushViewController:lvc animated:YES];
}
@end
