//
//  NewsViewController.m
//  FarEasternU
//
//  Created by Q on 7/20/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *unselectedImage = [UIImage imageNamed:@"icon_news"];
    UIImage *selectedImage = [UIImage imageNamed:@"icon_news_selected"];
    
    [self.tabbar setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabbar setSelectedImage: selectedImage];
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

@end
