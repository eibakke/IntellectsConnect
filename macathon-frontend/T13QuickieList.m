//
//  T13QuickieList.m
//  macathon-frontend
//
//  Created by Sam Olsen on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import "T13QuickieList.h"
#import "AFHTTPRequestOperationManager.h"
#import "T13MainController.h"

@interface T13QuickieList()
{
    NSIndexPath *index_path;
}

@end

@implementation T13QuickieList

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hangouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"QuickieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    [df_local setDateFormat:@"EEE, dd LLL yyyy HH:mm:ss vvv"];
    NSDate *d = [df_local dateFromString:self.hangouts[indexPath.row][@"time"]];
    [df_local setDateFormat:@"hh:mm a"];
    
    NSString *name = self.hangouts[indexPath.row][@"owner"];
    NSString *time = [df_local stringFromDate:d];
    NSString *place = self.hangouts[indexPath.row][@"place"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", place, time];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    index_path = indexPath;
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"Confirm";
    alert.message = @"Commit to this time and place?";
    alert.delegate = self;
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
}

- (void)mainThreadDoStuff:(NSDictionary *)info
{
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    [df_local setDateFormat:@"EEE, dd LLL yyyy HH:mm:ss vvv"];
    NSDate *d = [df_local dateFromString:info[@"time"]];
    [df_local setDateFormat:@"MM/dd hh:mm a"];
    
    //NSString *next = [NSString stringWithFormat:@"Meet %@ at %@ (%@)", info[@"owner"], info[@"place"], [df_local stringFromDate:d]];
    //[self.parent performSelectorOnMainThread:@selector(tackOn:) withObject:next waitUntilDone:NO];
    [(T13MainController *)self.parent tackOn:info[@"owner"] atPlace:info[@"place"] andTime:[df_local stringFromDate:d]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) // YES
    {
        NSDictionary *info = self.hangouts[index_path.row];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id": info[@"id"]};
        [manager POST:@"http://141.140.128.106:3000/accept" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Accepted hangout!!");
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:self.hangouts];
            [arr removeObject:info];
            self.hangouts = arr;
            UITableView *taable = [(T13MainController *)self.parent quickiesTableView];
            [taable beginUpdates];
            [taable deleteRowsAtIndexPaths:@[index_path] withRowAnimation:UITableViewRowAnimationRight];
            [taable endUpdates];
            
            [self performSelectorOnMainThread:@selector(mainThreadDoStuff:) withObject:info waitUntilDone:NO];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"Yikes");
        }];
    }
}

@end
