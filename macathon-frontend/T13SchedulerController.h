//
//  T13SchedulerController.h
//  macathon-frontend
//
//  Created by Tessa Danguillecourt on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T13SchedulerController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *placeTextField;
@property (weak, nonatomic) IBOutlet UITextField *personTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateAndTimePicker;

@end
