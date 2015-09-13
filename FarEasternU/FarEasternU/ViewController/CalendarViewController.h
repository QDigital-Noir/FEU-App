//
//  CalendarViewController.h
//  FarEasternU
//
//  Created by Q on 9/10/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController <JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabbar;

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@end
