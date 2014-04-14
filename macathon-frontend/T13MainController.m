//
//  T13MainController.m
//  macathon-frontend
//
//  Created by Sam Olsen on 3/1/14.
//  Copyright (c) 2014 Team 13. All rights reserved.
//

#import "T13MainController.h"
#import "AFHTTPRequestOperationManager.h"
#import "T13QuickieList.h"
#import "FXBlurView.h"

@interface T13MainController ()
{
    BOOL slidRight;
    UIGestureRecognizer *tapRecognizer;
    BOOL pickerVisible;
    T13QuickieList *tableDel;
    BOOL needsLoading;
}

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet FXBlurView *notificationView;
@property (weak, nonatomic) IBOutlet FXBlurView *quickieView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *placeTextField;
@property (weak, nonatomic) IBOutlet UIView *quickiesSlidingView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet FXBlurView *datePickerBack;
@property (nonatomic) int idx;

@end

@implementation T13MainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)prefsClick:(id)sender
{
    NSLog(@"PREFS CLICK");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    needsLoading = YES;
    slidRight = NO;
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [self.view addGestureRecognizer:tapRecognizer];
    tapRecognizer.delegate = self;
    self.quickieView.layer.cornerRadius = 20;
    self.notificationView.layer.cornerRadius = 20;
    tableDel = [[T13QuickieList alloc] init];
    tableDel.parent = self;
    self.quickiesTableView.delegate = tableDel;
    self.quickiesTableView.dataSource = tableDel;
    self.idx = 0;
    self.profileImage.layer.cornerRadius = 20;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://141.140.128.106:3000/quickies" parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        tableDel.hangouts = responseObject;
        [self.quickiesTableView performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
	// Do any additional setup after loading the view.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![touch.view isDescendantOfView:self.quickiesTableView] && ![touch.view isDescendantOfView:self.rightView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewTapped
{
    [self.placeTextField resignFirstResponder];
    if(pickerVisible)
    {
        pickerVisible = NO;
        
        CGRect pFrame = self.datePickerBack.frame;
        CGRect qFrame = self.quickieView.frame;
        
        qFrame.origin.y += 20;
        pFrame.origin.y += pFrame.size.height;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.quickieView.frame = qFrame;
            self.datePickerBack.frame = pFrame;
        }];
        
        NSDateFormatter *df_local = [[NSDateFormatter alloc] init];
        [df_local setDateFormat:@"MM/dd ss:mm"];
        self.timeLabel.text = [df_local stringFromDate:self.datePicker.date];
    }
    
    if(!slidRight)
        return;
    
    slidRight = NO;
    
    CGRect frame = self.centerView.frame;
    frame.origin.x = 0;
    CGRect rFrame = self.rightView.frame;
    rFrame.origin.x = 320;
    [UIView animateWithDuration:0.25 animations:^{
        self.centerView.frame = frame;
        self.rightView.frame = rFrame;
    }];
}

- (IBAction)slideRightPress:(id)sender
{
    if(slidRight)
        return;
    
    slidRight = YES;
    CGRect frame = self.centerView.frame;
    CGRect rFrame = self.rightView.frame;
    frame.origin.x = -self.rightView.frame.size.width;
    rFrame.origin.x -= rFrame.size.width;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.centerView.frame = frame;
        self.rightView.frame = rFrame;
    }];
}

//- (void)tackOn:(NSString *)str
//{
//    CGRect frame = CGRectMake(10, (15 * idx++) + 10, self.notificationView.frame.size.width - 20, 15);
//    UILabel *l = [[UILabel alloc] initWithFrame:frame];
//    l.font = [UIFont systemFontOfSize:12];
//    l.text = str;
//    [self.notificationView addSubview:l];
//}

- (void)tackOn:(NSString *)name atPlace:(NSString *)place andTime:(NSString *)time
{
    CGRect nameRect = CGRectMake(10, (15 * self.idx) + 40, 100, 15);
    UILabel *nameL = [[UILabel alloc] initWithFrame:nameRect];
    nameL.font = [UIFont systemFontOfSize:14];
    nameL.text = name;
    nameL.textColor = [UIColor colorWithRed:1 green:153.0/255 blue:0 alpha:1.0];
    
    CGRect restRect = CGRectMake(70, (15 * self.idx++) + 40, 200, 15);
    UILabel *restL = [[UILabel alloc] initWithFrame:restRect];
    restL.font = [UIFont systemFontOfSize:14];
    restL.text = [NSString stringWithFormat:@"%@ @ %@", place, time];
    
    [self.notificationView addSubview:nameL];
    [self.notificationView addSubview:restL];
}

- (IBAction)newPressed:(id)sender
{
    CGRect frame = self.quickiesSlidingView.frame;
    CGRect outer = self.quickieView.frame;
    frame.origin.x = 0;
    outer.size.height = 148;
    [UIView animateWithDuration:0.2 animations:^{
        self.quickiesSlidingView.frame = frame;
        self.quickieView.frame = outer;
    }];
}

- (IBAction)browsePress:(id)sender
{
    CGRect frame = self.quickiesSlidingView.frame;
    CGRect outer = self.quickieView.frame;
    outer.size.height = 267;
    frame.origin.x = -280;
    [UIView animateWithDuration:0.1 animations:^{
        self.quickieView.frame = outer;
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.quickiesSlidingView.frame = frame;
            }];
        }
    }];
}

- (IBAction)timePress:(id)sender
{
    if(pickerVisible)
        return;
    
    pickerVisible = YES;
    CGRect pFrame = self.datePickerBack.frame;
    CGRect qFrame = self.quickieView.frame;
    
    qFrame.origin.y -= 20;
    pFrame.origin.y -= pFrame.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.quickieView.frame = qFrame;
        self.datePickerBack.frame = pFrame;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

- (IBAction)setupPress:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"datetime": [self getUTCFormateDate:self.datePicker.date],
                             @"place": self.placeTextField.text,
                             @"kind": @"quickie"};
    [manager POST:@"http://141.140.128.106:3000/newhangout" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"New hangout added!");
        self.placeTextField.text = @"";
        self.timeLabel.text = @"";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
        NSLog(@"Yikes");
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    slidRight = NO;
    
    if(!needsLoading)
        return;
    
    needsLoading = NO;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://141.140.128.106:3000/upcoming" parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        int i = 0;
        for(NSDictionary *dict in responseObject)
        {
            NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
            [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
            [df_local setDateFormat:@"EEE, dd LLL yyyy HH:mm:ss vvv"];
            NSDate *d = [df_local dateFromString:dict[@"time"]];
            [df_local setDateFormat:@"MM/dd hh:mm a"];
            
            [self tackOn:dict[@"other"] atPlace:dict[@"place"] andTime:[df_local stringFromDate:d]];
            
//            CGRect frame = CGRectMake(10, (15 * i++) + 10, self.notificationView.frame.size.width - 20, 15);
//            UILabel *l = [[UILabel alloc] initWithFrame:frame];
//            l.font = [UIFont systemFontOfSize:12];
//            l.text = [NSString stringWithFormat:@"Meet %@ at %@ (%@)", dict[@"other"], dict[@"place"], [df_local stringFromDate:d]];
//            [self.notificationView addSubview:l];
        }
        //idx = i;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
