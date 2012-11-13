//
//  DetailOverlay.h
//  TableHeaderScrollPadSample
//
//  Created by Will Fairclough on 2012-11-13.
//  Copyright (c) 2012 Will Fairclough. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailOverlay : UIView

@property (nonatomic, strong) UILabel *sectionLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

- (id) initWithScrollPad:(UIView *)scrollPad;

@end
