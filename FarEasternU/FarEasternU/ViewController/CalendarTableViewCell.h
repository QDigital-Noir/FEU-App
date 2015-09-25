//
//  CalendarTableViewCell.h
//  FarEasternU
//
//  Created by Q on 9/10/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic, strong) UILabel *titleLB;

- (void)setContentViewWithFrame:(CGRect)frame andTitle:(NSString *)title andPhoto:(PFFile *)photo;
@end
