//
//  PSCollectionViewCell.m
//  LoopsSrollView
//
//  Created by pingsheng on 15/4/30.
//  Copyright (c) 2015年 pingsheng.zhao. All rights reserved.
//

#import "PSCollectionViewCell.h"

@implementation PSCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self addSubview:imageView];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}
@end
