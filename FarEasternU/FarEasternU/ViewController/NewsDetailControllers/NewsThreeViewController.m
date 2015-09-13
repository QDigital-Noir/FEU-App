//
//  NewsThreeViewController.m
//  FarEasternU
//
//  Created by Q on 9/12/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "NewsThreeViewController.h"
#import "NewsEventTableViewCell.h"

@interface NewsThreeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *newsTBV;
@property (nonatomic, strong) NSArray *newsArray;

@end

@implementation NewsThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"COOL");
    [self loadData];
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

#pragma mark - Setup Empty View

- (void)setupEmptyScreen
{
    UILabel *emptyLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - (170 + 20), 70)];
    emptyLB.backgroundColor = [UIColor clearColor];
    emptyLB.font = [UIFont fontWithName:@"ThaiSansNeue-SemiBold" size:28.0f];
    emptyLB.textColor = [UIColor blackColor];
    emptyLB.text = @"Empty List";
    emptyLB.lineBreakMode = NSLineBreakByTruncatingTail;
    emptyLB.numberOfLines = 0;
    emptyLB.textAlignment = NSTextAlignmentCenter;
    emptyLB.center = CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height/2) - 90);
    [self.view addSubview:emptyLB];
}

#pragma mark - Setup TableView

- (void)setupTableView
{
    self.newsTBV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.newsTBV.delegate = self;
    self.newsTBV.dataSource = self;
    self.newsTBV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.newsTBV];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    NewsEventTableViewCell *cell;
    if(cell == nil)
    {
        cell = [[NewsEventTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(NewsEventTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PFObject *object = [self.newsArray objectAtIndex:indexPath.row];
    
    [cell setContentViewWithFrame:self.view.frame
                         andTitle:[object objectForKey:@"NewsTitle"]
                           andURL:@""];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

#pragma mark - Fetch Data

- (void)loadData
{
    [KVNProgress showWithStatus:@"Loading"];
    PFQuery *newsQuery = [PFQuery queryWithClassName:@"News"];
    [newsQuery whereKey:@"type" equalTo:[NSNumber numberWithInt:3]];
    [newsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            //success
            if (!error)
            {
                if (objects != nil && objects.count != 0)
                {
                    // success
                    NSLog(@"%@", objects);
                    if (self.newsArray != nil || self.newsArray.count > 0)
                    {
                        self.newsArray = nil;
                        self.newsArray = [NSArray arrayWithArray:objects];
                    }
                    else
                    {
                        self.newsArray = [NSArray arrayWithArray:objects];
                    }
                    [self setupTableView];
                    [KVNProgress dismiss];
                    //                    [self.newsTBV reloadData];
                }
                else
                {
                    // success but not found
                    [self setupEmptyScreen];
                    [KVNProgress dismiss];
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
@end
