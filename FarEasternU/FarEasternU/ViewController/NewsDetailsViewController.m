//
//  NewsDetailsViewController.m
//  FarEasternU
//
//  Created by Q on 9/13/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "NewsDetailsViewController.h"

const NSInteger kPreloadCount = 3;
const NSInteger kNumberOfImages = 12;

@interface NewsDetailsViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) NSArray *photosArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupDetailView];
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
    self.mainScrollView.backgroundColor = [UIColor greenColor];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    self.headerImageView.backgroundColor = [UIColor redColor];
    self.headerImageView.userInteractionEnabled = YES;
    
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, self.headerImageView.frame.size.height + gap, self.view.frame.size.width - 20, 50)];
    self.titleLB.backgroundColor = [UIColor grayColor];
    self.titleLB.font = [UIFont fontWithName:@"" size:20.0f];
    self.titleLB.textColor = [UIColor blackColor];
    self.titleLB.textAlignment = NSTextAlignmentLeft;
    self.titleLB.numberOfLines = 0;
    self.titleLB.text = @"Lorem Ipsum";
    
    self.detailLB = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLB.frame.origin.y + self.titleLB.frame.size.height + gap, self.view.frame.size.width - 20, self.view.frame.size.height)];
    self.detailLB.backgroundColor = [UIColor grayColor];
    self.detailLB.font = [UIFont fontWithName:@"" size:20.0f];
    self.detailLB.textColor = [UIColor blackColor];
    self.detailLB.textAlignment = NSTextAlignmentLeft;
    self.detailLB.numberOfLines = 0;
    self.detailLB.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
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

#pragma mark - ImageViewer Trigger

- (void)showImageViewer
{
    NSLog(@"TEST");
    RDImageViewerController *viewController = [[RDImageViewerController alloc] initWithImageHandler:^UIImage *(NSInteger pageIndex) {
        return self.dataArray[pageIndex];
    } numberOfImages:self.dataArray.count direction:RDPagingViewDirectionRight];
    viewController.autoBarsHiddenDuration = 1;
    viewController.showSlider = NO;
    viewController.showPageNumberHud = YES;
    viewController.landscapeMode = RDImageScrollViewResizeModeAspectFit;
    viewController.preloadCount = kPreloadCount;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Fetch Data

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    PFQuery *detailQuery = [PFQuery queryWithClassName:@"NewsPhotos"];
    [detailQuery whereKey:@"News" equalTo:self.newsObj];
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
                            }
                        }];
                    }
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

@end
