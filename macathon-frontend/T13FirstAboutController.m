//
//  T13FirstAboutController.m
//  macathon-frontend
//
//  Created by Sam Olsen on 2/28/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import "T13FirstAboutController.h"
#import "AFHTTPRequestOperationManager.h"

@interface T13FirstAboutController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;
@property (strong, nonatomic) UIGestureRecognizer *tapGestureRecognizer;

@end

@implementation T13FirstAboutController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
	// Do any additional setup after loading the view.
}

- (void)tapped:(id)sender
{
    [self.nameTextField resignFirstResponder];
    [self.yearTextField resignFirstResponder];
    [self.majorTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpPressed:(id)sender
{
    AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableSet *jsonAcceptableContentTypes = [NSMutableSet setWithSet:jsonResponseSerializer.acceptableContentTypes];
    [jsonAcceptableContentTypes addObject:@"text/plain"];
    jsonResponseSerializer.acceptableContentTypes = jsonAcceptableContentTypes;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = jsonResponseSerializer;
    NSDictionary *params = @{@"fullname": self.nameTextField.text,
                             @"email": self.email,
                             @"password": self.password,
                             @"major": self.majorTextField.text,
                             @"grade": self.yearTextField.text};
    [manager POST:@"http://141.140.128.106:3000/signup" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"New user added!");
        [self performSegueWithIdentifier:@"FirstMainSegue" sender:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
