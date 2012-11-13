//
//  DetailOverlay.m
//  TableHeaderScrollPadSample
//
//  Created by Will Fairclough on 2012-11-13.
//  Copyright (c) 2012 Will Fairclough. All rights reserved.
//

#import "DetailOverlay.h"
#import <QuartzCore/QuartzCore.h>

#define kDetailOverlayWidth 150.0
#define kDetailOverlayHeight 100.0
#define kDetailOverlayOffset 5.0

@implementation DetailOverlay
@synthesize sectionLabel, descriptionLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, frame.size.width - 10.0, 20.0)];
        sectionLabel.font = [UIFont systemFontOfSize:12.0];
        sectionLabel.textColor = [UIColor whiteColor];
        sectionLabel.adjustsFontSizeToFitWidth = YES;
        sectionLabel.minimumScaleFactor = 0.5;
        sectionLabel.backgroundColor = [UIColor clearColor];
        
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 30.0, frame.size.width - 10.0, 65.0)];
        descriptionLabel.font = [UIFont systemFontOfSize:10.0];
        descriptionLabel.textColor = [UIColor whiteColor];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.numberOfLines = 0;
        
        [self addSubview:sectionLabel];
        [self addSubview:descriptionLabel];

    }
    return self;
}

- (id) initWithScrollPad:(UIView *)scrollPad
{
    self = [self initWithFrame:CGRectMake(scrollPad.frame.origin.x - kDetailOverlayWidth - kDetailOverlayOffset, 0.0, kDetailOverlayWidth, kDetailOverlayHeight)];
    
    if (self)
    {
        
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
