//
//  CalendarViewController.m
//  FarEasternU
//
//  Created by Q on 9/10/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarTableViewCell.h"
#import "CalendarDetailViewController.h"

@interface CalendarViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableDictionary *_eventsByDate;
    
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    NSDate *_dateSelected;
}

@property (nonatomic, strong) UITableView *eventTVB;
@property (nonatomic, strong) NSMutableArray *eventArray;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
    UIImage *unselectedImage = [UIImage imageNamed:@"icon_news"];
    UIImage *selectedImage = [UIImage imageNamed:@"icon_news_selected"];
    
    [self.tabbar setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabbar setSelectedImage: selectedImage];
    [self setupCalendar];
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

#pragma mark - Setup Calendar

- (void)setupCalendar
{
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
//    [self createRandomEvents];
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];
    
    [self adjustCalendarView];
}


#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [_calendarManager setDate:_todayDate];
}

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    //    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date])
    {
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending)
        {
            [_calendarContentView loadNextPageWithAnimation];
        }
        else
        {
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
        NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
        NSLog(@"Previous page loaded");
}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate]; // DATE
        [_eventsByDate[key] addObject:@""]; // THUMBNAIL
        [_eventsByDate[key] addObject:@""]; // TITLE
        [_eventsByDate[key] addObject:@""]; // DESCRIPTION
    }
}

#pragma mark - Adjusting View

- (void)adjustCalendarView
{
    self.calendarMenuView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.calendarMenuView.frame.size.height - 40);
    self.calendarContentView.frame = CGRectMake(0, self.calendarMenuView.frame.size.height - 64, self.view.frame.size.width, 300);
    
    [self createEventTableView];
}

#pragma mark - Create Event TableView

- (void)createEventTableView
{
    self.eventTVB = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                  self.calendarContentView.frame.size.height + self.calendarContentView.frame.origin.y,
                                                                  self.view.frame.size.width,
                                                                  self.view.frame.size.height - (self.calendarContentView.frame.size.height + self.calendarContentView.frame.origin.y))
                                                 style:UITableViewStylePlain];
    self.eventTVB.delegate = self;
    self.eventTVB.dataSource = self;
    self.eventTVB.backgroundColor = [UIColor whiteColor];
    self.eventTVB.hidden = YES;
    [self.view addSubview:self.eventTVB];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.eventArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    CalendarTableViewCell *cell;
    if(cell == nil)
    {
        cell = [[CalendarTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(CalendarTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@" ==== %@", [self.eventArray objectAtIndex:indexPath.row]);
    PFObject *object = [self.eventArray objectAtIndex:indexPath.row];
    [cell setContentViewWithFrame:self.view.frame
                         andTitle:[object objectForKey:@"CalendarTitle"]];
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CalendarDetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"CalendarDetailViewController"];
    detailVC.calendarObj = (PFObject *)[self.eventArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

#pragma mark - Fetch Data

- (void)loadData
{
    NSDate *date = [NSDate date]; //I'm using this just to show the this is how you convert a date
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle]; // day, Full month and year
    
    NSString *dateString = [df stringFromDate:date];
    NSString *monthString = [[dateString componentsSeparatedByString:@" "] firstObject];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Calendar"];
    [query whereKey:@"CalendarMonth" equalTo:monthString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            //success
            if (!error)
            {
                if (objects != nil && objects.count != 0)
                {
                    // success
                    NSLog(@"%@", objects);
                    _eventsByDate = [NSMutableDictionary new];
                    self.eventArray = [NSMutableArray array];
                    for (PFObject *obj in objects)
                    {
                        [self eventsParserWithObject:obj];
                        [self.eventArray addObject:obj];
                    }
                    
                    _calendarContentView.hidden = NO;
                    _calendarMenuView.hidden = NO;
                    self.eventTVB.hidden = NO;
                    [self.eventTVB reloadData];
                    [_calendarManager reload];
                }
                else
                {
                    // success but not found
                }
            }
            else
            {
                // error
            }
        }
        else
        {
            //error
        }
    }];
}

#pragma mark - Events Parser

- (void)eventsParserWithObject:(PFObject *)obj
{
    NSString *key = [[self dateFormatter] stringFromDate:[obj objectForKey:@"CalendarStartDate"]];
    
    if(!_eventsByDate[key])
    {
        _eventsByDate[key] = [NSMutableArray new];
    }
    PFFile *photo = obj[@"Thumbnail"];
    [_eventsByDate[key] addObject:[obj objectForKey:@"CalendarStartDate"]]; // DATE
    [_eventsByDate[key] addObject:[obj objectForKey:@"CalendarTitle"]]; // TITLE
    [_eventsByDate[key] addObject:[obj objectForKey:@"CalendarDetail"]]; // DESCRIPTION
    
    NSLog(@"EVENT : %@", _eventsByDate);
}

#pragma mark - Buttom Actions

- (IBAction)homeTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www2.feu.ac.th/thai/main.php"]];
}

- (IBAction)facebookTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/FEUFriends"]];
}

@end
