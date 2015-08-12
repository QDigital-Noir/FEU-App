//
//  StepApplyViewController.m
//  FarEasternU
//
//  Created by Q on 8/12/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "StepApplyViewController.h"

@interface StepApplyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@end

@implementation StepApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.applyBtn.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 30);
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

#pragma mark - Btn Actions

- (IBAction)applyBtnTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www2.feu.ac.th/admin/pr/admission58/reg.html"]];
    //https://www.facebook.com/FEUFriends
}

@end
