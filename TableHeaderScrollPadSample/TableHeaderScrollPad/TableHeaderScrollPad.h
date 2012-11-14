//
//  TableHeaderScrollPad.h
//  TableHeaderScrollPadSample
//
//  Created by Will Fairclough on 2012-11-12.
//  Copyright (c) 2012 Will Fairclough. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableHeaderScrollPad;

typedef enum {
    
    kTableHeaderScrollPadStyleDark,
    kTableHeaderScrollPadStyleLight
    
} TableHeaderScrollPadStyle;


typedef enum {
    
    kTableHeaderScrollPadStateNormal,
    kTableHeaderScrollPadStateDragging
    
} TableHeaderScrollPadState;




@protocol TableHeaderScrollPadDelegate <NSObject>

@optional
- (NSString *) tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad titleForHeaderInSection:(NSInteger)section;
- (NSString *) tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad descriptionForHeaderInSection:(NSInteger)section;
- (BOOL) shouldDisplayInfoOverlayForTableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad;
- (void) didSelectTabOnScrollPad:(TableHeaderScrollPad *)scrollPad atSection:(NSInteger)section;

@required
- (NSInteger) numberOfSectionsInTableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad;

@end



@protocol TableHeaderScrollPadTouchesDelegate <NSObject>

@required
- (void)tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end



@interface TableHeaderScrollPad : UIView <TableHeaderScrollPadTouchesDelegate>

@property (nonatomic, assign) id <TableHeaderScrollPadDelegate> delegate;
@property (nonatomic, strong) UITableView *tableView;

- (id) initWithStyle:(TableHeaderScrollPadStyle)style frame:(CGRect)frame;

@end