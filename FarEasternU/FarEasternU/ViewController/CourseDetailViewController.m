//
//  CourseDetailViewController.m
//  FarEasternU
//
//  Created by Q on 8/6/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseMajorDetailViewController.h"

@interface CourseDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.majorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell;
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = self.majorArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"ThaiSansNeue-SemiBold" size:26.0f];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"");
    
    CourseMajorDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseMajorDetailViewController"];
    controller.title = self.majorArray[indexPath.row];
    controller.courseTitle = self.majorArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
