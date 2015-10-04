//
//  CalendarDetailViewController.m
//  FarEasternU
//
//  Created by Q on 9/25/15.
//  Copyright © 2015 Q. All rights reserved.
//

#import "CalendarDetailViewController.h"

//const NSInteger kPreloadCount = 3;
//const NSInteger kNumberOfImages = 12;

@interface CalendarDetailViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) NSMutableArray *photosArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [self.calendarObj objectForKey:@"CalendarTitle"];
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

#pragma mark - Setup View

- (void)setupDetailView
{
    float gap = 10.0f;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    self.headerImageView.backgroundColor = [UIColor clearColor];
    self.headerImageView.userInteractionEnabled = YES;
    self.headerImageView.image = self.photosArray[0];
    
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, self.headerImageView.frame.size.height + gap, self.view.frame.size.width - 20, 50)];
    self.titleLB.backgroundColor = [UIColor clearColor];
    self.titleLB.font = [UIFont fontWithName:@"ThaiSansNeue-ExtraBold" size:24.0f];
    self.titleLB.textColor = [UIColor blackColor];
    self.titleLB.textAlignment = NSTextAlignmentLeft;
    self.titleLB.numberOfLines = 0;
    self.titleLB.text = [self.calendarObj objectForKey:@"Title"];
    
    self.detailLB = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLB.frame.origin.y + self.titleLB.frame.size.height + gap, self.view.frame.size.width - 20, self.view.frame.size.height)];
    self.detailLB.backgroundColor = [UIColor clearColor];
    self.detailLB.font = [UIFont fontWithName:@"ThaiSansNeue-Regular" size:20.0f];
    self.detailLB.textColor = [UIColor blackColor];
    self.detailLB.textAlignment = NSTextAlignmentLeft;
    self.detailLB.numberOfLines = 0;
    self.detailLB.text = [self.calendarObj objectForKey:@"Description"];
    [self.detailLB sizeToFit];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headerImageView];
    [self.mainScrollView addSubview:self.titleLB];
    [self.mainScrollView addSubview:self.detailLB];
    
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.detailLB.frame.origin.y + self.detailLB.frame.size.height + 100);
    
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageViewer)];
    tapGuesture.numberOfTapsRequired = 1;
    tapGuesture.numberOfTouchesRequired = 1;
    [self.headerImageView addGestureRecognizer:tapGuesture];
}

- (void)setupDetailViewWithoutImage
{
    float gap = 10.0f;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 50)];
    self.titleLB.backgroundColor = [UIColor clearColor];
    self.titleLB.font = [UIFont fontWithName:@"ThaiSansNeue-ExtraBold" size:24.0f];
    self.titleLB.textColor = [UIColor blackColor];
    self.titleLB.textAlignment = NSTextAlignmentLeft;
    self.titleLB.numberOfLines = 0;
    self.titleLB.text = [self.calendarObj objectForKey:@"CalendarTitle"];
    
    self.detailLB = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLB.frame.origin.y + self.titleLB.frame.size.height + gap, self.view.frame.size.width - 20, self.view.frame.size.height)];
    self.detailLB.backgroundColor = [UIColor clearColor];
    self.detailLB.font = [UIFont fontWithName:@"ThaiSansNeue-Regular" size:20.0f];
    self.detailLB.textColor = [UIColor blackColor];
    self.detailLB.textAlignment = NSTextAlignmentLeft;
    self.detailLB.numberOfLines = 0;
    self.detailLB.text = [self.calendarObj objectForKey:@"CalendarDetail"];
    [self.detailLB sizeToFit];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.titleLB];
    [self.mainScrollView addSubview:self.detailLB];
    
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.detailLB.frame.origin.y + self.detailLB.frame.size.height + 100);
}

#pragma mark - ImageViewer Trigger

- (void)showImageViewer
{
    RDImageViewerController *viewController = [[RDImageViewerController alloc] initWithImageHandler:^UIImage *(NSInteger pageIndex) {
        return self.photosArray[pageIndex];
    } numberOfImages:self.photosArray.count direction:RDPagingViewDirectionRight];
    viewController.autoBarsHiddenDuration = 1;
    viewController.showSlider = NO;
    viewController.showPageNumberHud = YES;
    viewController.landscapeMode = RDImageScrollViewResizeModeAspectFit;
    viewController.preloadCount = 3;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Load Data

- (void)loadData
{
    [KVNProgress showWithStatus:@"Loading"];
    self.dataArray = [NSMutableArray array];
    PFQuery *detailQuery = [PFQuery queryWithClassName:@"CalendarPhoto"];
    [detailQuery whereKey:@"CalendarID" equalTo:self.calendarObj];
    [detailQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            //success
            if (!error)
            {
                if (objects != nil && objects.count != 0)
                {
                    // success
                    for (int i = 0; i < objects.count; i++)
                    {
                        PFObject *obj = objects[i];
                        PFFile *photo = obj[@"Photo"];
                        [photo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                            if (!error)
                            {
                                [self.dataArray addObject:[UIImage imageWithData:imageData]];
                                if (self.dataArray.count == objects.count)
                                {
                                    [self setupDetailView];
                                    [KVNProgress dismiss];
                                }
                            }
                        }];
                    }
                }
                else
                {
                    // success but not found
                    [self setupDetailViewWithoutImage];
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
