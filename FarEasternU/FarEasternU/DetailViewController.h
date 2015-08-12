//
//  DetailViewController.h
//  FarEasternU
//
//  Created by Q on 7/19/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

