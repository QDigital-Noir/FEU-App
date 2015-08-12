//
//  CourseMajorDetailViewController.m
//  FarEasternU
//
//  Created by Q on 8/6/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "CourseMajorDetailViewController.h"

@interface CourseMajorDetailViewController ()

@end

@implementation CourseMajorDetailViewController

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

#pragma mark - Setup Views

- (void)setupMainView
{
    float gap = 15.0f;
    NSDictionary *dict = [self getCourseDetailDictWithName:self.courseTitle];
    
    UIImageView *headerIV = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, self.view.frame.size.width + 10, 190)];
    headerIV.backgroundColor = [UIColor greenColor];
    headerIV.image = [UIImage imageNamed:dict[@"course_image"]];
    headerIV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:headerIV];
    
    UITextView *majorTV = [[UITextView alloc] initWithFrame:CGRectMake(10, headerIV.frame.size.height + gap, self.view.frame.size.width - 20, self.view.frame.size.height - headerIV.frame.size.height - gap - 110)];
    majorTV.backgroundColor = [UIColor clearColor];
    majorTV.textAlignment = NSTextAlignmentLeft;
    majorTV.editable = NO;
    [self.view addSubview:majorTV];

    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:dict[@"course_html"] ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    majorTV.attributedText = attributedString;
}

#pragma mark - helper

- (NSDictionary *)getCourseDetailDictWithName:(NSString *)name
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"course" ofType:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    NSDictionary *returnDict = [NSDictionary dictionary];
    for (NSDictionary *courseDict in dict[@"Course"])
    {
        if ([courseDict[@"course_name"] isEqualToString:name])
        {
            returnDict = courseDict;
            NSLog(@"FOUND");
            break;
        }
        else
        {
            NSLog(@"NOT FOUND");
        }
    }
    
    return returnDict;
}

@end
