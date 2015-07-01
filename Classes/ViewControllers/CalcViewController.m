//
//  CalcViewController.m
//
//  Copyright (c) 2015 Evgeny Aleksandrov. All rights reserved.

#import "CalcViewController.h"
#import "LoadListViewController.h"

#define LBSinKG 2.204622622

@interface CalcViewController ()

@end

@implementation CalcViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* inputChain = @[self.massMetric, self.massImperial, self.gearMetric, self.gearImperial, self.canopySize, self.canopyLoad];
    self.keyboardControls = [[APLKeyboardControls alloc] initWithInputFields:inputChain];
    self.keyboardControls.hasPreviousNext = YES;
    
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.canopySize attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:-5];
    self.bottomConstraint.priority = 995;
    [self.view addConstraint:self.bottomConstraint];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self loadValues];
}

#pragma mark - UITextField delegate

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    BOOL backspaceKey = newLength < oldLength;
    
    if(textField == self.massMetric || textField == self.gearMetric) {
        return newLength <= 4 || returnKey || backspaceKey;
    } else if(textField == self.massImperial || textField == self.gearImperial) {
        return newLength <= 6 || returnKey || backspaceKey;
    } else if(textField == self.canopySize) {
        return newLength <= 3 || returnKey || backspaceKey;
    }
    
    return newLength <= 4 || returnKey || backspaceKey;
}

#pragma mark - Notification Handlers

- (void)keyboardWillShow:(NSNotification *)sender {
    CGRect frame = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect newFrame = [self.view convertRect:frame fromView:[[UIApplication sharedApplication] delegate].window];
    self.bottomConstraint.constant = newFrame.origin.y - CGRectGetHeight(self.view.frame) - 5;
    [self.view layoutIfNeeded];
}

- (void)keyboardWillHide:(NSNotification *)sender {
    self.bottomConstraint.constant = - 5;
    [self.view layoutIfNeeded];
}

#pragma mark - Private - save/load

- (void)loadValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumIntegerDigits:1];
    [formatter setMaximumFractionDigits:1];
    
    NSNumber *canopySize = [defaults objectForKey:@"canopySize"];
    if(!canopySize) {
        canopySize = @(150);
    }
    
    NSNumber *massImperial = [defaults objectForKey:@"massImperial"];
    if(!massImperial) {
        massImperial = @(180);
    }
    
    NSNumber *gearImperial = [defaults objectForKey:@"gearImperial"];
    if(!gearImperial) {
        gearImperial = @(20);
    }
    
    self.canopySize.text = [formatter stringFromNumber:canopySize];
    self.massImperial.text = [formatter stringFromNumber:massImperial];
    self.gearImperial.text = [formatter stringFromNumber:gearImperial];
    
    [self imperialValuesChanged:nil];
}

- (void)saveValues {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@([[formatter numberFromString:self.canopySize.text] doubleValue]) forKey:@"canopySize"];
    [defaults setObject:@([[formatter numberFromString:self.massImperial.text] doubleValue]) forKey:@"massImperial"];
    [defaults setObject:@([[formatter numberFromString:self.gearImperial.text] doubleValue]) forKey:@"gearImperial"];
    [defaults synchronize];
}

#pragma mark - Actions

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)metricValuesChanged:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumIntegerDigits:1];
    [formatter setMaximumFractionDigits:1];
    
    double massMetric = [[formatter numberFromString:self.massMetric.text] doubleValue];
    double gearMetric = [[formatter numberFromString:self.gearMetric.text] doubleValue];
    
    double massImperial = massMetric * LBSinKG;
    double gearImperial = gearMetric * LBSinKG;
    
    self.massImperial.text = [formatter stringFromNumber:@(massImperial)];
    self.gearImperial.text = [formatter stringFromNumber:@(gearImperial)];
    
    double canopySize = [[formatter numberFromString:self.canopySize.text] doubleValue];
    
    double canopyLoad = (massImperial + gearImperial) / canopySize;
    
    [formatter setMaximumFractionDigits:2];
    self.canopyLoad.text = [formatter stringFromNumber:@(canopyLoad)];
    
    [self saveValues];
}

- (IBAction)imperialValuesChanged:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumIntegerDigits:1];
    [formatter setMaximumFractionDigits:1];
    
    double massImperial = [[formatter numberFromString:self.massImperial.text] doubleValue];
    double gearImperial = [[formatter numberFromString:self.gearImperial.text] doubleValue];
    
    double massMetric = massImperial / LBSinKG;
    double gearMetric = gearImperial / LBSinKG;
    
    self.massMetric.text = [formatter stringFromNumber:@(massMetric)];
    self.gearMetric.text = [formatter stringFromNumber:@(gearMetric)];
    
    double canopySize = [[formatter numberFromString:self.canopySize.text] doubleValue];
    
    double canopyLoad = (massImperial + gearImperial) / canopySize;
    
    [formatter setMaximumFractionDigits:2];
    self.canopyLoad.text = [formatter stringFromNumber:@(canopyLoad)];
    
    [self saveValues];
}

- (IBAction)canopyChanged:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumIntegerDigits:1];
    [formatter setMaximumFractionDigits:2];
    
    double massImperial = [[formatter numberFromString:self.massImperial.text] doubleValue];
    double gearImperial = [[formatter numberFromString:self.gearImperial.text] doubleValue];
    double canopySize = [[formatter numberFromString:self.canopySize.text] doubleValue];
    
    double canopyLoad = (massImperial + gearImperial) / canopySize;
    self.canopyLoad.text = [formatter stringFromNumber:@(canopyLoad)];
    
    [self saveValues];
}

- (IBAction)loadChanged:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    double massImperial = [[formatter numberFromString:self.massImperial.text] doubleValue];
    double gearImperial = [[formatter numberFromString:self.gearImperial.text] doubleValue];
    double canopyLoad = [[formatter numberFromString:self.canopyLoad.text] doubleValue];
    
    double canopySize =  (massImperial + gearImperial) / canopyLoad;
    self.canopySize.text = [formatter stringFromNumber:@(canopySize)];
    
    [self saveValues];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"LoadListSegue"]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setMaximumFractionDigits:2];
        
        LoadListViewController *listVc = (LoadListViewController *)[segue destinationViewController];
        listVc.chosenWeight = [[formatter numberFromString:self.massImperial.text] doubleValue] + [[formatter numberFromString:self.gearImperial.text] doubleValue];
        listVc.chosenCanopy = [[formatter numberFromString:self.canopySize.text] doubleValue];
    }
}

@end
