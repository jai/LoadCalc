//
//  CalcViewController.h
//
//  Copyright (c) 2015 Evgeny Aleksandrov. All rights reserved.

#import <UIKit/UIKit.h>
#import "APLKeyboardControls.h"

@interface CalcViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *massMetric;
@property (nonatomic, weak) IBOutlet UITextField *massImperial;
@property (nonatomic, weak) IBOutlet UITextField *gearMetric;
@property (nonatomic, weak) IBOutlet UITextField *gearImperial;
@property (nonatomic, weak) IBOutlet UITextField *canopySize;
@property (nonatomic, weak) IBOutlet UITextField *canopyLoad;

@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong) APLKeyboardControls *keyboardControls;

@end
