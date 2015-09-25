//
//  CalendarTableViewCell.m
//  FarEasternU
//
//  Created by Q on 9/10/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "CalendarTableViewCell.h"

@implementation CalendarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentViewWithFrame:(CGRect)frame andTitle:(NSString *)title andPhoto:(PFFile *)photo
{
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, frame.size.width - 40, 60)];
    self.titleLB.backgroundColor = [UIColor clearColor];
    self.titleLB.font = [UIFont fontWithName:@"ThaiSansNeue-SemiBold" size:18.0f];
    self.titleLB.textColor = [UIColor blackColor];
    self.titleLB.text = title;
    self.titleLB.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLB.numberOfLines = 0;
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLB.frame.origin.x + self.titleLB.frame.size.width - 10, 18, 24, 24)];
    arrow.backgroundColor = [UIColor clearColor];
    arrow.image = [UIImage imageNamed:@"right"];
    
    [self.contentView addSubview:self.titleLB];
    [self.contentView addSubview:arrow];
}

@end
