//
//  T13PreferencesController.m
//  macathon-frontend
//
//  Created by Tessa Danguillecourt on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import "T13PreferencesController.h"

@interface T13PreferencesController ()

@end

@implementation T13PreferencesController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)smokeStepperChange:(UIStepper*)sender
{
    if ([sender value] <= 10) {
        [[self smokeLabel] setText:[NSString stringWithFormat:@"%d/10", (int)[sender value]]];
    }
}

- (IBAction)musicStepperChange:(UIStepper*)sender
{
    if ([sender value] <= 10) {
        [[self musicLabel] setText:[NSString stringWithFormat:@"%d/10", (int)[sender value]]];
    }
}

- (IBAction)foodStepperChange:(UIStepper*)sender
{
    if ([sender value] <= 10) {
        [[self foodLabel] setText:[NSString stringWithFormat:@"%d/10", (int)[sender value]]];
    }
}

- (IBAction)conversationStepperChange:(UIStepper*)sender
{
    if ([sender value] <= 10) {
        [[self conversationLabel] setText:[NSString stringWithFormat:@"%d/10", (int)[sender value]]];
    }
}
@end
