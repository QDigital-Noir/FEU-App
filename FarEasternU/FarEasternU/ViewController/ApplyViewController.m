//
//  ApplyViewController.m
//  FarEasternU
//
//  Created by Q on 7/20/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "ApplyViewController.h"
#import "StepOneViewController.h"
#import "StepTwoViewController.h"
#import "StepThreeViewController.h"
#import "StepFourViewController.h"
#import "StepFiveViewController.h"
#import "StepSixViewController.h"
#import "StepSevenViewController.h"
#import "StepApplyViewController.h"

@interface ApplyViewController () <GUITabPagerDataSource, GUITabPagerDelegate>
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIImage *unselectedImage = [UIImage imageNamed:@"icon_apply"];
//    UIImage *selectedImage = [UIImage imageNamed:@"icon_apply_selected"];
//    
//    [self.tabbar setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [self.tabbar setSelectedImage: selectedImage];
    self.titleArray = @[@"ขั้นตอนการรับสมัคร",
                        @"รายละเอียดกำหนดการ",
                        @"คุณสมบัติและเอกสาร",
                        @"สำหรับผู้จบปวส.",
                        @"สำหรับผู้จบสถาบันอื่น",
                        @"สำหรับผู้จบต่างประเทศ",
                        @"ค่าเทอม",
                        @"สมัครออนไลน์"];
    [self setDataSource:self];
    [self setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
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

#pragma mark - Tab Pager Data Source

- (NSInteger)numberOfViewControllers {
    return self.titleArray.count;
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0)
    {
        StepOneViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StepOneViewController"];
        return vc;
    }
    else if (index == 1)
    {
        StepTwoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StepTwoViewController"];
        return vc;
    }
    else if (index == 2)
    {
        StepThreeViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StepThreeViewController"];
        return vc;
    }
    else if (index == 3)
    {
        StepFourViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StepFourViewController"];
        return vc;
    }
    else if (index == 4)
    {
        StepFiveViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StepFiveViewController"];
        return vc;
    }
    else if (index == 5)
    {
        StepSixViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StepSixViewController"];
        return vc;
    }
    else if (index == 6)
    {
        StepSevenViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StepSevenViewController"];
        return vc;
    }
    else
    {
        StepApplyViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StepApplyViewController"];
        return vc;
    }
}

// Implement either viewForTabAtIndex: or titleForTabAtIndex:
//- (UIView *)viewForTabAtIndex:(NSInteger)index {
//  return [self createView1];
//}

- (NSString *)titleForTabAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%@", self.titleArray[(long) index]];
}

- (CGFloat)tabHeight {
    // Default: 44.0f
    return 50.0f;
}

- (UIColor *)tabColor {
    // Default: [UIColor orangeColor];
    return [UIColor colorWithRed:255/255.0f green:240/255.0f blue:0.0f alpha:1.0f];
}

- (UIColor *)tabBackgroundColor {
    // Default: [UIColor colorWithWhite:0.95f alpha:1.0f];
    return [UIColor blackColor];
}

- (UIFont *)titleFont {
    // Default: [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
    return [UIFont fontWithName:@"ThaiSansNeue-ExtraBold" size:20.0f];
}

- (UIColor *)titleColor {
    // Default: [UIColor blackColor];
    return [UIColor colorWithRed:255/255.0f green:240/255.0f blue:0.0f alpha:1.0f];
}

#pragma mark - Tab Pager Delegate

- (void)tabPager:(GUITabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index {
    NSLog(@"Will transition from tab %ld to %ld", [self selectedIndex], (long)index);
}

- (void)tabPager:(GUITabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index {
    NSLog(@"Did transition to tab %ld", (long)index);
}

#pragma mark - Views

- (UIView *)createView1
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0f
                                           green:arc4random_uniform(255) / 255.0f
                                            blue:arc4random_uniform(255) / 255.0f alpha:1];
    
    UITextView *descTV = [[UITextView alloc] initWithFrame:view.frame];
    descTV.backgroundColor = [UIColor clearColor];
    descTV.textAlignment = NSTextAlignmentLeft;
    descTV.editable = NO;
    [view addSubview:descTV];

    return view;
}

@end
