//
//  StepOneViewController.m
//  FarEasternU
//
//  Created by Q on 8/12/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "StepOneViewController.h"

@interface StepOneViewController ()

@end

@implementation StepOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - Setup View

- (void)setupMainView
{
    self.view.backgroundColor = [UIColor colorWithRed:7/255.0f green:48/255.0f blue:126/255.0f alpha:1.0f];
    self.detailTV.frame = CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 20);
    self.detailTV.font = [UIFont fontWithName:@"ThaiSansNeue-ExtraBold" size:18.0];
    self.detailTV.textColor = [UIColor whiteColor];
    self.detailTV.backgroundColor = [UIColor colorWithRed:7/255.0f green:48/255.0f blue:126/255.0f alpha:1.0f];;
}


@end
