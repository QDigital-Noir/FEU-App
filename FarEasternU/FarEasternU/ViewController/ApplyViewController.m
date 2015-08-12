//
//  ApplyViewController.m
//  FarEasternU
//
//  Created by Q on 7/20/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "ApplyViewController.h"

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
    self.titleArray = @[@"ขั้นตอนการรับสมัคร", @"รายละเอียดกำหนดการ", @"คุณสมบัติและเอกสาร", @"สำหรับผู้จบปวส." @"สำหรับผู้จบสถาบันอื่น", @"สำหรับผู้จบต่างประเทศ", @"ค่าเทอม"];
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
    return 5;
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    UIViewController *vc = [UIViewController new];
    [[vc view] setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255) / 255.0f
                                                  green:arc4random_uniform(255) / 255.0f
                                                   blue:arc4random_uniform(255) / 255.0f alpha:1]];
    [vc.view addSubview:[self createView1]];
    return vc;
}

// Implement either viewForTabAtIndex: or titleForTabAtIndex:
//- (UIView *)viewForTabAtIndex:(NSInteger)index {
//  return [self createView1];
//}

- (NSString *)titleForTabAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%@", self.titleArray[(long) index + 1]];
}

- (CGFloat)tabHeight {
    // Default: 44.0f
    return 50.0f;
}

- (UIColor *)tabColor {
    // Default: [UIColor orangeColor];
    return [UIColor purpleColor];
}

- (UIColor *)tabBackgroundColor {
    // Default: [UIColor colorWithWhite:0.95f alpha:1.0f];
    return [UIColor lightTextColor];
}

- (UIFont *)titleFont {
    // Default: [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
}

- (UIColor *)titleColor {
    // Default: [UIColor blackColor];
    return [UIColor colorWithRed:1.0f green:0.8f blue:0.0f alpha:1.0f];
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
