//
//  TableHeaderScrollPad.m
//  TableHeaderScrollPadSample
//
//  Created by Will Fairclough on 2012-11-12.
//  Copyright (c) 2012 Will Fairclough. All rights reserved.
//

#import "TableHeaderScrollPad.h"

#define kBackgroundColorDark 46.0
#define kHeaderTabColorDark 87.0

#define kBackgroundColorLight 235.0
#define kHeaderTabColorLight 46.0

@interface TableHeaderScrollPad ()
{
    TableHeaderScrollPadStyle scrollPadStyle;
}


@end

@implementation TableHeaderScrollPad
@synthesize delegate;

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
    NSLog(@"Touch Began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    
    NSLog(@"Touch Moved x: %f   y: %f", [touch locationInView:self].x, [touch locationInView:self].y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touch Ended");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touch Canceled");
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    int numOfSections = [self.delegate numberOfSectionsInTableHeaderScrollPad:self];
    
    float scrollPadHeight = self.bounds.size.height;
    float scrollPadWidth = self.bounds.size.width;
    
    float heightPreSection = scrollPadHeight/numOfSections;
    
    for (int i = 0; i < numOfSections; i++)
    {
        UIView *section = [[UIView alloc] initWithFrame:CGRectMake(15.0, (i * heightPreSection) + (heightPreSection/2.0), scrollPadWidth - 30.0, 3.0)];
        
        if (scrollPadStyle == kTableHeaderScrollPadStyleLight)
        {
            [section setBackgroundColor:[UIColor colorWithRed:(kHeaderTabColorLight/255.0f) green:(kHeaderTabColorLight/255.0f) blue:(kHeaderTabColorLight/255.0f) alpha:1.0]];
        }
        else
        {
            [section setBackgroundColor:[UIColor colorWithRed:(kHeaderTabColorDark/255.0f) green:(kHeaderTabColorDark/255.0f) blue:(kHeaderTabColorDark/255.0f) alpha:1.0]];
        }
        
        [self addSubview:section];
    }
    
    NSLog(@"Section %d", [self.delegate numberOfSectionsInTableHeaderScrollPad:self]);
}


@end
