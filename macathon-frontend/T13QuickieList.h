//
//  T13QuickieList.h
//  macathon-frontend
//
//  Created by Sam Olsen on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface T13QuickieList : NSObject <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *hangouts;
@property (nonatomic, weak) id parent;

@end
