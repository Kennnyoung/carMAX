//
//  SignupViewController.m
//  carMax
//
//  Created by Yuhao Kan on 2017-07-27.
//  Copyright © 2017 Modiface Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignupViewController.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;

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


@end
