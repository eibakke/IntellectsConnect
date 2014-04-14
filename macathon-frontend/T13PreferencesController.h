//
//  T13PreferencesController.h
//  macathon-frontend
//
//  Created by Tessa Danguillecourt on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T13PreferencesController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *smokeLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *conversationLabel;

- (IBAction)smokeStepperChange:(UIStepper*)sender;
- (IBAction)musicStepperChange:(UIStepper*)sender;
- (IBAction)foodStepperChange:(UIStepper*)sender;
- (IBAction)conversationStepperChange:(UIStepper*)sender;



@end
