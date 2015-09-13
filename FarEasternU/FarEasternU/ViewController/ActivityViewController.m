//
//  ActivityViewController.m
//  FarEasternU
//
//  Created by Q on 7/20/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController () <CKCalendarViewDelegate, CKCalendarViewDataSource>
@property (nonatomic, strong) NSMutableDictionary *data;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *unselectedImage = [UIImage imageNamed:@"icon_activity"];
    UIImage *selectedImage = [UIImage imageNamed:@"icon_activity_selected"];
    
    [self.tabbar setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabbar setSelectedImage: selectedImage];
    
    [self setupMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Setup Views

- (void)setupMainView
{
    /**
     *  Create a dictionary for the data source
     */
    
    self.data = [[NSMutableDictionary alloc] init];
    
    /**
     *  Wire up the data source and delegate.
     */
    
    /**
     *  Create some events.
     */
    
    //  An event for the new MBCalendarKit release.
    NSString *title = NSLocalizedString(@"Release MBCalendarKit 2.2.4", @"");
    NSDate *date = [NSDate dateWithDay:28 month:8 year:2015];
    CKCalendarEvent *releaseUpdatedCalendarKit = [CKCalendarEvent eventWithTitle:title andDate:date andInfo:nil];
    
    //  An event for the new Hunger Games movie.
    NSString *title2 = NSLocalizedString(@"The Hunger Games: Mockingjay, Part 1", @"");
    NSDate *date2 = [NSDate dateWithDay:21 month:8 year:2015];
    CKCalendarEvent *mockingJay = [CKCalendarEvent eventWithTitle:title2 andDate:date2 andInfo:nil];
    
    //  Integrate MBCalendarKit
    NSString *integrationTitle = NSLocalizedString(@"Integrate MBCalendarKit", @"");
    NSDate *integrationDate = date2;
    CKCalendarEvent *integrationEvent = [CKCalendarEvent eventWithTitle:integrationTitle andDate:integrationDate andInfo:nil];
    
    //  An event for the new MBCalendarKit release.
    NSString *title3 = NSLocalizedString(@"Fix bug where events don't show up immediately.", @"");
    NSDate *date3 = [NSDate dateWithDay:13 month:8 year:2015];
    CKCalendarEvent *fixBug = [CKCalendarEvent eventWithTitle:title3 andDate:date3 andInfo:nil];
    
    
    /**
     *  Add the events to the data source.
     *
     *  The key is the date that the array of events appears on.
     */
    
    self.data[date] = @[releaseUpdatedCalendarKit];
    self.data[date2] = @[mockingJay, integrationEvent];
    self.data[date3] = @[fixBug];
    
    // 1. Instantiate a CKCalendarView
    CKCalendarView *calendar = [CKCalendarView new];
    
    // 2. Optionally, set up the datasource and delegates
    [calendar setDelegate:self];
    [calendar setDataSource:self];
    
    // 3. Present the calendar
//    [[self view] addSubview:calendar];
}

#pragma mark - CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date
{
    return [self data][date];
}

#pragma mark - CKCalendarViewDelegate

// Called before/after the selected date changes
- (void)calendarView:(CKCalendarView *)CalendarView willSelectDate:(NSDate *)date
{
    NSLog(@"WILL SELECT DATE : %@", date);
}

- (void)calendarView:(CKCalendarView *)CalendarView didSelectDate:(NSDate *)date
{
    NSLog(@"SELECTED DATE : %@", date);
}

//  A row is selected in the events table. (Use to push a detail view or whatever.)
- (void)calendarView:(CKCalendarView *)CalendarView didSelectEvent:(CKCalendarEvent *)event
{
    
}

@end
