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
@synthesize states;
@synthesize tableView;

#pragma mark - Initializing

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"StateCities" ofType:@"plist"];
        states = [[NSDictionary dictionaryWithContentsOfFile:dataPath] retain];
        
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
    
    self.scrollPad.tableView = self.tableView;
}




#pragma mark - TableHeaderScrollPadDelegate

- (NSString *) tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad titleForHeaderInSection:(NSInteger)section
{
    NSString *stateKey = [[states allKeys] objectAtIndex:section];
//    NSArray *cities = [states objectForKey:stateKey];

    return stateKey;
}

- (NSString *) tableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad descriptionForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section Description for %d", section];    
}

/*
 Will display the Detailed Overlay about each section if returned YES
 
 Default will return YES.
 */
//- (BOOL) shouldDisplayInfoOverlayForTableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad
//{
//    return YES;
//}

- (NSInteger) numberOfSectionsInTableHeaderScrollPad:(TableHeaderScrollPad *)scrollPad
{
    return [[states allKeys] count];
}

- (void) didSelectTabOnScrollPad:(TableHeaderScrollPad *)scrollPad atSection:(NSInteger)section
{
    NSLog(@"Did select tab at index %d", section);
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *stateKey = [[states allKeys] objectAtIndex:section];
    NSArray *cities = [states objectForKey:stateKey];
    return [cities count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[states allKeys] count];
}


- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *stateKey = [[states allKeys] objectAtIndex:section];
    
    return stateKey;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *stateKey = [[states allKeys] objectAtIndex:indexPath.section];
    NSArray *cities = [states objectForKey:stateKey];
    NSString *city = [cities objectAtIndex:indexPath.row];
    
    cell.textLabel.text = city;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
