//
//  NewsEventTableViewCell.m
//  FarEasternU
//
//  Created by Q on 8/31/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "NewsEventTableViewCell.h"

@implementation NewsEventTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentViewWithFrame:(CGRect)frame andTitle:(NSString *)title andURL:(NSString *)url
{
    self.thumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 90)];
    self.thumbImageView.backgroundColor = [UIColor greenColor];
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www2.feu.ac.th/thai/thumbnail.php?src=/admin/pr/newscontrol/picture/J120150818104757.JPG&w=210&h=150"]
                           placeholderImage:nil];
    
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, frame.size.width - (170 + 20), 70)];
    self.titleLB.backgroundColor = [UIColor clearColor];
    self.titleLB.font = [UIFont fontWithName:@"ThaiSansNeue-SemiBold" size:18.0f];
    self.titleLB.textColor = [UIColor blackColor];
    self.titleLB.text = title;
    self.titleLB.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLB.numberOfLines = 0;
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLB.frame.origin.x + self.titleLB.frame.size.width - 10, 34, 24, 24)];
    arrow.backgroundColor = [UIColor clearColor];
    arrow.image = [UIImage imageNamed:@"right"];
    
    [self.contentView addSubview:self.thumbImageView];
    [self.contentView addSubview:self.titleLB];
    [self.contentView addSubview:arrow];
}

@end
