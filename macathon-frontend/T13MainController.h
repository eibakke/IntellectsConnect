//
//  T13MainController.h
//  macathon-frontend
//
//  Created by Sam Olsen on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T13MainController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *quickiesTableView;

- (void)tackOn:(NSString *)str;
- (void)tackOn:(NSString *)name atPlace:(NSString *)place andTime:(NSString *)time;

@end
