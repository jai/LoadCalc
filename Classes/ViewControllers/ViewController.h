//
//  ViewController.h
//  LoadCalc
//
//  Created by Evgeny Aleksandrov on 15/07/14.
//  Copyright (c) 2014 Ferret Syndicate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APLKeyboardControls.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *massMetric;
@property (nonatomic, weak) IBOutlet UITextField *massImperial;
@property (nonatomic, weak) IBOutlet UITextField *gearMetric;
@property (nonatomic, weak) IBOutlet UITextField *gearImperial;
@property (nonatomic, weak) IBOutlet UITextField *canopySize;
@property (nonatomic, weak) IBOutlet UITextField *canopyLoad;

@property (nonatomic, strong) APLKeyboardControls *keyboardControls;

@end
