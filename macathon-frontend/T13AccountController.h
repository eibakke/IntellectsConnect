//
//  T13AccountController.h
//  macathon-frontend
//
//  Created by Tessa Danguillecourt on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T13AccountController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *collegeTextField;
@property (weak, nonatomic) IBOutlet UITextField *favoriteStudySpot;
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *accountImage;

@end
