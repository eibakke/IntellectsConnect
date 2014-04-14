//
//  T13ViewController.m
//  macathon-frontend
//
//  Created by Sam Olsen on 2/28/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import "T13ViewController.h"
#import "T13FirstAboutController.h"
#import "AFHTTPRequestOperationManager.h"
#import "FXBlurView.h"

@interface T13ViewController ()
{
    BOOL verifyTextFieldVisible;
    BOOL validEmailFormat;
}

@property (weak, nonatomic) IBOutlet FXBlurView *blurView;

@end

@implementation T13ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
	// Do any additional setup after loading the view, typically from a nib.
    verifyTextFieldVisible = NO;
    validEmailFormat = NO;
    
    self.blurView.blurRadius = 17;
    self.blurView.tintColor = [UIColor whiteColor];
    
     [[self userNameTextField] setDelegate:self];
     [[self passwordTextField] setDelegate:self];
     [[self verifyPasswordTextField] setDelegate:self];
    
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackground:)];
    [self.view addGestureRecognizer:tapBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInButton:(id)sender {
    if ([self isValidMacalesterEmailLogIn]){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"username": self.userNameTextField.text, @"password": self.passwordTextField.text};
        [manager POST:@"http://141.140.128.106:3000/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self performSegueWithIdentifier:@"DirectMainSegue" sender:self];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

- (IBAction)signUpButton:(id)sender {
    if (!verifyTextFieldVisible) {
        [self signUpClickFade];
        verifyTextFieldVisible = YES;
    } else if ([self isValidMacalesterEmailSignUp]) {
        [self performSegueWithIdentifier:@"AboutSegue" sender:self];
    }
}

- (void)signUpClickFade
{
    [UIView animateWithDuration:0.7 animations:^{
        self.verifyPasswordTextField.alpha = 1.0;
        self.logInButton.alpha = 0.0;
    }];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"AboutSegue"])
    {
        T13FirstAboutController *ctl = segue.destinationViewController;
        ctl.email = self.userNameTextField.text;
        ctl.password = self.passwordTextField.text;
    }
}

- (void)alertUser:(NSString*) alertMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Input"
                                                    message:alertMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) animateButtons: (BOOL) up
{
    const int movementDistance = 80;
    const float movementDuration = 0.1f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView animateWithDuration:movementDuration
                     animations:^{
                         self.logInButton.frame = CGRectMake(self.logInButton.frame.origin.x, (self.logInButton.frame.origin.y + movement), self.logInButton.frame.size.width, self.logInButton.frame.size.height);
                         self.signUpButton.frame = CGRectMake(self.signUpButton.frame.origin.x, (self.signUpButton.frame.origin.y + movement) , self.signUpButton.frame.size.width, self.signUpButton.frame.size.height);

        
                     }];
}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    NSString *emailRegex = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL)isValidMacalesterEmailSignUp
{
    NSArray* emailArray = [[[self userNameTextField] text] componentsSeparatedByString: @"@"];
    
    if ([[[self userNameTextField] text] isEqualToString:@""] || [[[self passwordTextField] text] isEqualToString:@""]){
        [self alertUser:@"Please enter a Macalester email address and password."];
        return NO;
    } else if (!([[[self passwordTextField] text] isEqualToString:[[self verifyPasswordTextField] text]])){
        [self alertUser:@"Please enter matching passwords."];
        return NO;
    } else if ([self NSStringIsValidEmail:[[self userNameTextField] text]]) {
        if([[emailArray objectAtIndex:1] isEqualToString:@"macalester.edu"]){
            return YES;
        } else {
            [self alertUser:@"Only Macalester students can use this app."];
            return NO;
        }
    } else {
        [self alertUser:@"Not validly formatted email."];
        return NO;
    }
}

-(BOOL)isValidMacalesterEmailLogIn
{
    NSArray* emailArray = [[[self userNameTextField] text] componentsSeparatedByString: @"@"];
    if ([[[self userNameTextField] text] isEqualToString:@""] || [[[self passwordTextField] text] isEqualToString:@""]){
        [self alertUser:@"Please enter a Macalester email address and a password."];
        return NO;
    } else if ([self NSStringIsValidEmail:[[self userNameTextField] text]]) {
        if([[emailArray objectAtIndex:1] isEqualToString:@"macalester.edu"]){
            return YES;
        } else {
            [self alertUser:@"Only Macalester students can use this app."];
            return NO;
        }
    } else {
        [self alertUser:@"Not validly formatted email."];
        return NO;
    }
}

- (void)tapBackground:(UIGestureRecognizer *)gestureRecognizer;
{
    [[self userNameTextField] resignFirstResponder];
    [[self passwordTextField] resignFirstResponder];
    [[self verifyPasswordTextField] resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
