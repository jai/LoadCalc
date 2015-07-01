//
//  LoadListViewController.m
//
//  Copyright (c) 2015 Evgeny Aleksandrov. All rights reserved.

#import "LoadListViewController.h"

@interface LoadListViewController () {
    NSArray *loadsArray;
}

@end

@implementation LoadListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *canopySizes = @[@65,@70,@75,@80,@85,@90,@95,@100,@110,@120,@130,@150,@170,@190,@200,@210,@220,@240,@260,@280];
    
    if(![canopySizes containsObject:@(self.chosenCanopy)]) {
        canopySizes = [canopySizes arrayByAddingObject:@(self.chosenCanopy)];
        canopySizes = [canopySizes sortedArrayUsingSelector:@selector(compare:)];
    }
    
    NSMutableArray *tempLoads = @[].mutableCopy;
    for (NSNumber *canopySize in canopySizes) {
        [tempLoads addObject:@{
                               @"canopySize" : canopySize,
                               @"canopyLoad" : @(self.chosenWeight/[canopySize doubleValue])
                               }];
    }
    
    loadsArray = [tempLoads copy];
    [self.tableView reloadData];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"canopySize == %@", @(self.chosenCanopy)];
    NSArray *filteredArray = [loadsArray filteredArrayUsingPredicate:predicate];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[loadsArray indexOfObject:filteredArray[0]] inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [loadsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadCell" forIndexPath:indexPath];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumIntegerDigits:1];
    [formatter setMaximumFractionDigits:2];
    
    NSNumber *cellCanopy = [[loadsArray objectAtIndex:indexPath.row] objectForKey:@"canopySize"];
    NSNumber *cellLoad = [[loadsArray objectAtIndex:indexPath.row] objectForKey:@"canopyLoad"];
    
    [cell.textLabel setText:[formatter stringFromNumber:cellCanopy]];
    [cell.detailTextLabel setText:[formatter stringFromNumber:cellLoad]];
    
    if([cellLoad doubleValue] < 1.0f) {
        [cell.detailTextLabel setTextColor:[UIColor colorWithRed:46.0/255.0f green:139.0/255.0f blue:87.0/255.0f alpha:1.0f]];
    } else if([cellLoad doubleValue] < 1.3f) {
        [cell.detailTextLabel setTextColor:[UIColor blueColor]];
    } else if([cellLoad doubleValue] < 1.5f) {
        [cell.detailTextLabel setTextColor:[UIColor colorWithRed:30.0/255.0f green:144.0/255.0f blue:255.0/255.0f alpha:1.0f]];
    } else if([cellLoad doubleValue] < 1.7f) {
        [cell.detailTextLabel setTextColor:[UIColor colorWithRed:250.0/255.0f green:128.0/255.0f blue:114.0/255.0f alpha:1.0f]];
    } else if([cellLoad doubleValue] < 1.7f) {
        [cell.detailTextLabel setTextColor:[UIColor colorWithRed:255.0/255.0f green:127.0/255.0f blue:80.0/255.0f alpha:1.0f]];
    } else if([cellLoad doubleValue] < 2.0f) {
        [cell.detailTextLabel setTextColor:[UIColor colorWithRed:255.0/255.0f green:99.0/255.0f blue:71.0/255.0f alpha:1.0f]];
    } else {
        [cell.detailTextLabel setTextColor:[UIColor redColor]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
