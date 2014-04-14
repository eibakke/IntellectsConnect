//
//  T13AccountController.m
//  macathon-frontend
//
//  Created by Tessa Danguillecourt on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import "T13AccountController.h"
#import "AFHTTPRequestOperationManager.h"

@interface T13AccountController ()

@end

@implementation T13AccountController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.accountImage.layer.cornerRadius = 92 / 2;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://141.140.128.106:3000/info" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *personInfo = responseObject;
        self.nameTextField.text = [personInfo objectForKey:@"name"];
        self.emailTextField.text = [personInfo objectForKey:@"email"];
        if(personInfo[@"major"])
            self.majorTextField.text = [personInfo objectForKey:@"major"];
        if(personInfo[@"grade"])
            self.yearTextField.text = [(NSNumber *)[personInfo objectForKey:@"grade"] stringValue];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
         }];
    }

@end
