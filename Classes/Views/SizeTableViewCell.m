//
//  SizeTableViewCell.m
//
//  Copyright (c) 2015 Evgeny Aleksandrov. All rights reserved.

#import "SizeTableViewCell.h"
#import <ChameleonFramework/Chameleon.h>


@implementation SizeTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor flatWhiteColorDark];
    [self setSelectedBackgroundView:bgColorView];
}

@end
