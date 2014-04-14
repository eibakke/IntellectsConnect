//
//  T13ViewController.h
//  macathon-frontend
//
//  Created by Sam Olsen on 2/28/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T13ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)logInButton:(id)sender;
- (IBAction)signUpButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end
