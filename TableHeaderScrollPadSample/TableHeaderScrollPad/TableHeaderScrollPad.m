//
//  TableHeaderScrollPad.m
//  TableHeaderScrollPadSample
//
//  Created by Will Fairclough on 2012-11-12.
//  Copyright (c) 2012 Will Fairclough. All rights reserved.
//

#import "TableHeaderScrollPad.h"
#import "DetailOverlay.h"
#import <QuartzCore/QuartzCore.h>


#define kBackgroundColorDark 46.0
#define kHeaderTabColorDark 87.0

#define kBackgroundColorLight 235.0
#define kHeaderTabColorLight 46.0

@interface TableHeaderScrollPad ()
{
    TableHeaderScrollPadStyle scrollPadStyle;
    float sectionHeight;
    BOOL touchBegan;
    int selectedSectionIndex;
}

@property (nonatomic, strong) NSMutableArray *tabViews;
@property (nonatomic, strong) DetailOverlay *detailOverlay;

@end

@implementation TableHeaderScrollPad
@synthesize delegate, tabViews, detailOverlay;

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithStyle:kTableHeaderScrollPadStyleDark frame:frame];
    if (self) {
        
    }
    return self;
}

- (id) initWithStyle:(TableHeaderScrollPadStyle)style frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        scrollPadStyle = style;
        if (style == kTableHeaderScrollPadStyleLight)
        {
            [self setBackgroundColor:[UIColor colorWithRed:(kBackgroundColorLight/255.0f) green:(kBackgroundColorLight/255.0f) blue:(kBackgroundColorLight/255.0f) alpha:1.0]];
        }
        else // kTableHeaderScrollPadStyleDark
        {
            [self setBackgroundColor:[UIColor colorWithRed:(kBackgroundColorDark/255.0f) green:(kBackgroundColorDark/255.0f) blue:(kBackgroundColorDark/255.0f) alpha:1.0]];
        }
    }
    return self;
}

#pragma mark - TableHeaderScrollPadTouchesDelegate

- (void)tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    touchBegan = YES;

    [UIView animateWithDuration:0.3 animations:^{
        detailOverlay.alpha = 1.0;
    }];
    
    [self updateTabsScaleWithTouch:[touches anyObject]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateTabsScaleWithTouch:[touches anyObject]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchBegan = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        if (touchBegan == NO)
        {
            [UIView animateWithDuration:1.0 animations:^{
                detailOverlay.alpha = 0.0;
            }];
        }
    });
    
    
    if (self.delegate != nil)
    {
        [self.delegate didSelectTabOnScrollPad:self atSection:selectedSectionIndex];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) updateTabsScaleWithTouch:(UITouch *)touch
{

    float posX = [touch locationInView:self].x;
    float posY = [touch locationInView:self].y;
    
//    if (posX < 0)
//        return;
    
    int skipIndex = -1;
    
    for (int i = 0; i < [self.tabViews count]; i++)
    {
        UIView *tab = [self.tabViews objectAtIndex:i];
        UIView *prevTab = nil;
        UIView *nextTab = nil;
        
        if (skipIndex == i)
            return;
        
        if ((i-1) >= 0)
        {
            prevTab = [self.tabViews objectAtIndex:(i-1)];
        }
        
        if ((i+1) < [self.tabViews count])
        {
            nextTab = [self.tabViews objectAtIndex:(i+1)];
        }
        
        float minRange = (i * sectionHeight);
        float maxRange = (i * sectionHeight) + sectionHeight;
        
        float minRange2 = (i * sectionHeight) + sectionHeight;
        float maxRange2 = (i * sectionHeight) + (sectionHeight*2.0);
        
        if ((posY > minRange) && (posY < maxRange))
        {
            selectedSectionIndex = i;
            
            if (self.delegate != nil)
            {
                detailOverlay.sectionLabel.text = [self.delegate tableHeaderScrollPad:self titleForHeaderInSection:i];
                detailOverlay.descriptionLabel.text = [self.delegate tableHeaderScrollPad:self descriptionForHeaderInSection:i];
            }
            
            [UIView animateWithDuration:0.5 animations:^{
            
                CGPoint point = [self.superview convertPoint:tab.frame.origin fromView:nil];
                float dPosY = point.y - (detailOverlay.frame.size.height/2);

                detailOverlay.transform = CGAffineTransformMakeTranslation(0.0, dPosY);
                
            }];
            
            [UIView animateWithDuration:0.5 animations:^{
                tab.transform = CGAffineTransformMakeScale(1.8, 3.0);

                if (prevTab != nil)
                {
                    prevTab.transform = CGAffineTransformMakeScale(1.5, 2.0);
                }
                
                if (nextTab != nil)
                {
                    nextTab.transform = CGAffineTransformMakeScale(1.5, 2.0);
                }
            }];
            
            skipIndex = i - 1;
            
            i++;
            
        }
        else if ((posY > minRange2) && (posY < maxRange2))
        {
            [UIView animateWithDuration:0.5 animations:^{
                tab.transform = CGAffineTransformMakeScale(1.5, 2.0);
            }];
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                tab.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }
    }

}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (self.delegate == nil)
        return;
    
    // Drawing code
    
    int numOfSections = [self.delegate numberOfSectionsInTableHeaderScrollPad:self];
    
    float scrollPadHeight = self.bounds.size.height;
    float scrollPadWidth = self.bounds.size.width;
    
    float heightPreSection = scrollPadHeight/numOfSections;
    
    sectionHeight = heightPreSection;
    
    self.tabViews = [NSMutableArray arrayWithCapacity:numOfSections];
    
    for (int i = 0; i < numOfSections; i++)
    {
        float tabHeight = 3.0;
        float tabLeftOffset = 15.0;
        
//        if (i == 0)
//        {
//            tabHeight = 8.0;
//            tabLeftOffset = 6.0;
//        }
//        else if (i == 1)
//        {
//            tabHeight = 5.0;
//            tabLeftOffset = 10.0;
//        }
        
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(tabLeftOffset, (i * heightPreSection) + (heightPreSection/2.0), scrollPadWidth - tabLeftOffset*2.0, tabHeight)];
        
        if (scrollPadStyle == kTableHeaderScrollPadStyleLight)
        {
            [sectionView setBackgroundColor:[UIColor colorWithRed:(kHeaderTabColorLight/255.0f) green:(kHeaderTabColorLight/255.0f) blue:(kHeaderTabColorLight/255.0f) alpha:1.0]];
        }
        else
        {
            [sectionView setBackgroundColor:[UIColor colorWithRed:(kHeaderTabColorDark/255.0f) green:(kHeaderTabColorDark/255.0f) blue:(kHeaderTabColorDark/255.0f) alpha:1.0]];
        }
        
        sectionView.layer.cornerRadius = 1.5;
        sectionView.layer.masksToBounds = YES;
        
        [self.tabViews addObject:sectionView];
        
        [self addSubview:sectionView];
        
        if (detailOverlay == nil) {
            detailOverlay = [[DetailOverlay alloc] initWithScrollPad:self];
            [detailOverlay setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7]];
            detailOverlay.alpha = 0.0;
            [self.superview addSubview:detailOverlay];
            
            detailOverlay.sectionLabel.text = @"Section 1";
            detailOverlay.descriptionLabel.text = @"This is the description to test out this label with";
        }
    }

}


@end
