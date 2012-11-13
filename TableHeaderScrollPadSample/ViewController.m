//
//  ViewController.m
//  TableHeaderScrollPadSample
//
//  Created by Will Fairclough on 2012-11-12.
//  Copyright (c) 2012 Will Fairclough. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize scrollPad = _scrollPad;


#pragma mark - Initializing

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.scrollPad = [[TableHeaderScrollPad alloc] initWithStyle:kTableHeaderScrollPadStyleDark frame:CGRectMake(260.0, 0.0, 60.0, 568.0)];
        self.scrollPad.delegate = self;
        
        [self.view addSubview:self.scrollPad];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}




#pragma mark - TableHeaderScrollPadDelegate

- (NSString *) tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %d", section];
}

- (NSString *) tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad descriptionForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section Description for %d", section];    
}

- (BOOL) shouldDisplayInfoOverlayForTableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad
{
    return YES;
}

- (NSInteger) numberOfSectionsInTableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad
{
    return 45;
}

- (void) didSelectTabOnScrollPad:(TableHeaderScrollPad *)scrollPad atSection:(NSInteger)section
{
    NSLog(@"Did select tab at index %d", section);
}







#pragma mark - Closing

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollPad release];
    [super dealloc];
}
@end
