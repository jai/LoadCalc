//
//  LoadListViewController.m
//  LoadCalc
//
//  Created by Evgeny Aleksandrov on 11/08/14.
//  Copyright (c) 2014 Ferret Syndicate. All rights reserved.
//

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
    
    [cell.textLabel setText:[formatter stringFromNumber:[[loadsArray objectAtIndex:indexPath.row] objectForKey:@"canopySize"]]];
    [cell.detailTextLabel setText:[formatter stringFromNumber:[[loadsArray objectAtIndex:indexPath.row] objectForKey:@"canopyLoad"]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
