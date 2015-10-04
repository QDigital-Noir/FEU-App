//
//  CorseViewController.m
//  FarEasternU
//
//  Created by Q on 7/20/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "CorseViewController.h"
#import "CourseDetailViewController.h"
#import "ALCustomColoredAccessory.h"

@interface CorseViewController () <UITabBarDelegate>
@property NSMutableArray *objects;
@property NSArray *courseTypeArray;
@property NSArray *facultyArray;
@property NSArray *facultyMasterArray;;
@property NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *headerImageView;
@end

@implementation CorseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self setupData];
    [self setupMainView];
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
    
    NSLog(@"Available fonts: %@", [UIFont familyNames]);
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

#pragma mark - Initail Data

- (void)setupData
{
    self.facultyArray = @[@{@"MajorName" : @[@"สาขาวิชาการบัญชี",@"สาขาวิชาคอมพิวเตอร์ธุรกิจ",@"สาขาวิชาการตลาด",@"สาขาวิชาการประกอบการ",@"สาขาวิชาการจัดการการท่องเที่ยว",@"สาขาวิชาการจัดการ",@"สาขาวิชาการจัดการโลจิสติกส์อุตสาหกรรม"],
                            @"FacultyName" : @"คณะบริหารธุรกิจ",
                            @"FacultyDetail" : @""},
                          @{@"MajorName" : @[@"สาขาวิชาภาษาอังกฤษธุรกิจ",@"สาขาวิชาภาษาจีนธุรกิจ",@"สาขาวิชาภาษาญี่ปุ่นธุรกิจ",@"สาขาวิชาศึกษาทั่วไป"],
                            @"FacultyName" : @"คณะศิลปศาสตร์",
                            @"FacultyDetail" : @""},
                          @{@"MajorName" : @[@"สาขาวิชาเทคโนโลยีสารสนเทศ",@"สาขาวิชาภูมิสารสนเทศ"],
                            @"FacultyName" : @"คณะวิทยาศาสตร์และเทคโนโลยี",
                            @"FacultyDetail" : @""},
                          @{@"MajorName" : @[@"สาขาวิชาการสื่อสารการตลาด"],
                            @"FacultyName" : @"คณะนิเทศศาสตร์",
                            @"FacultyDetail" : @""},
                          @{@"MajorName" : @[@"สาขาวิชารัฐประศาสนศาสตร์"],
                            @"FacultyName" : @"คณะบริหารรัฐกิจ",
                            @"FacultyDetail" : @""},
                          @{@"MajorName" : @[@"สาขาวิชาการประถมศึกษา"],
                            @"FacultyName" : @"คณะศึกษาศาสตร์",
                            @"FacultyDetail" : @""}];
    
    self.facultyMasterArray = @[@{@"MajorName" : @[@"สาขาวิชาการเป็นผู้ประกอบการ (ปริญญาโท)"],
                                  @"FacultyName" : @"คณะบริหารธุรกิจ",
                                  @"FacultyDetail" : @""},
                                @{@"MajorName" : @[@"สาขาวิชาบริหารการศึกษา (ปริญญาโท)"],
                                  @"FacultyName" : @"คณะศึกษาศาสตร์",
                                  @"FacultyDetail" : @""}];
    
    self.courseTypeArray = @[@"หลักสูตรปริญญาตรี",@"หลักสูตรปริญญาโท",@"หลักสูตรระยะสั้น",@"หลักสูตรสำครับคนทำงาน"];
}

#pragma mark - Initail Views

- (void)setupMainView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 181)];
    headerView.backgroundColor = [UIColor greenColor];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 181)];
    self.headerImageView.image = [UIImage imageNamed:@"header"];
    self.headerImageView.contentMode = UIViewContentModeScaleToFill;
    self.headerImageView.backgroundColor = [UIColor redColor];
    [headerView addSubview:self.headerImageView];
    
    [self.view addSubview:headerView];
}

#pragma mark - Table View
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.courseTypeArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            if (section == 0)
            {
                return self.facultyArray.count + 1; // return rows when expanded
            }
            else if (section == 1)
            {
                return self.facultyMasterArray.count + 1;
            }
            else if (section == 2)
            {
                return 1;
            }
            else
            {
                return 1;
            }
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // first row
            cell.textLabel.text = [NSString stringWithFormat:@"%@", self.courseTypeArray[indexPath.section]]; // only top row showing
            cell.textLabel.font = [UIFont fontWithName:@"ThaiSansNeue-SemiBold" size:26.0f];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor blackColor];
            
            if ([expandedSections containsIndex:indexPath.section])
            {
                cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeUp];
            }
            else
            {
                cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeDown];
            }
        }
        else
        {
            if (indexPath.section == 0)
            {
                // all other rows
                NSDictionary *dict = self.facultyArray[indexPath.row-1];
                cell.textLabel.text = [NSString stringWithFormat:@"\t%@", dict[@"FacultyName"]];
                
            }
            else if (indexPath.section == 1)
            {
                NSDictionary *dict = self.facultyMasterArray[indexPath.row-1];
                cell.textLabel.text = [NSString stringWithFormat:@"\t%@", dict[@"FacultyName"]];
            }
            else if (indexPath.section == 2)
            {
                NSDictionary *dict = self.facultyMasterArray[1];
                cell.textLabel.text = [NSString stringWithFormat:@"\t%@", dict[@"FacultyName"]];
            }
            else
            {
                NSDictionary *dict = self.facultyMasterArray[1];
                cell.textLabel.text = [NSString stringWithFormat:@"\t%@", dict[@"FacultyName"]];
            }
            
            cell.textLabel.font = [UIFont fontWithName:@"ThaiSansNeue-SemiBold" size:20.0f];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIView *bgColorView = [[UIView alloc] initWithFrame:cell.frame];
            bgColorView.backgroundColor = [UIColor colorWithRed:255/255.0f green:240/255.0f blue:0.0f alpha:1.0f];
            [cell setSelectedBackgroundView:bgColorView];
        }
    }
    else
    {
        cell.accessoryView = nil;
        cell.textLabel.text = @"Normal Cell";
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // only first row toggles exapand/collapse
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                cell.accessoryView =  [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeUp];
                
            }
        }
        else {
            NSLog(@"Selected Section is %ld and subrow is %ld ",(long)indexPath.section ,(long)indexPath.row);
            NSDictionary *dict = self.facultyArray[indexPath.row-1];
            CourseDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
            controller.majorArray = dict[@"MajorName"];
            [self.navigationController pushViewController:controller animated:YES];
        }
        
    }
    else{
        CourseDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


#pragma mark - Buttom Actions

- (IBAction)homeTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www2.feu.ac.th/thai/main.php"]];
}

- (IBAction)facebookTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/FEUFriends"]];
}

#pragma mark - Load Data

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    PFQuery *query = [PFQuery queryWithClassName:@"Banners"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            //success
            if (!error)
            {
                if (objects != nil && objects.count != 0)
                {
                    // success
                    for (PFObject *obj in objects)
                    {
                        PFFile *photo = obj[@"BannerPhoto"];
                        [photo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                            if (!error)
                            {
                                [self.dataArray addObject:[UIImage imageWithData:imageData]];
                                if (self.dataArray.count == objects.count)
                                {
                                    [self randomDisplayBanner];
                                }
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

- (void)randomDisplayBanner
{
    //get random number
    int number = (int)self.dataArray.count;
    int randomImgNum = arc4random_uniform(number);
    
    //use your random number to get an image from your array
    UIImage *tempImg = [self.dataArray objectAtIndex:randomImgNum];
    
    //add your UIImage to a UIImageView and place it on screen somewhere
    self.headerImageView.image = tempImg;
    
    [self performSelector:@selector(randomDisplayBanner) withObject:nil afterDelay:5.0f];
}

@end
