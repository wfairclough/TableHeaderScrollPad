//
//  ScrollPadTab.m
//  TableHeaderScrollPadSample
//
//  Created by Will Fairclough on 2012-11-14.
//  Copyright (c) 2012 Will Fairclough. All rights reserved.
//

#import "ScrollPadTab.h"
#import <QuartzCore/QuartzCore.h>

#define kBorderRadius 1.5

@implementation ScrollPadTab
@synthesize isSelected;
@synthesize isBesideSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = kBorderRadius;
        self.layer.masksToBounds = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
