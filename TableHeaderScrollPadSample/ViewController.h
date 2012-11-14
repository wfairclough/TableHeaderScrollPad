//
//  ViewController.h
//  TableHeaderScrollPadSample
//
//  Created by Will Fairclough on 2012-11-12.
//  Copyright (c) 2012 Will Fairclough. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableHeaderScrollPad.h"

@interface ViewController : UIViewController <TableHeaderScrollPadDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet TableHeaderScrollPad *scrollPad;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *states;

@end
