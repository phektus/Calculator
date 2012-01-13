//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Arbie Samong on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize pipeline = _pipeline;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    
    NSRange rangeOfDot = [self.display.text rangeOfString:@"."];
    
    if (!([digit isEqualToString:@"."] && rangeOfDot.location != NSNotFound)) {
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.display.text = [self.display.text stringByAppendingString:digit];
        } else {
            self.display.text = digit;
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand: [self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.pipeline.text = [self.pipeline.text stringByAppendingString:[self.display.text stringByAppendingString:@" "]];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.pipeline.text = [self.pipeline.text stringByAppendingString:[sender.currentTitle stringByAppendingString:@" "]];
    self.display.text = resultString;
}

- (void)viewDidUnload {
    [self setPipeline:nil];
    [super viewDidUnload];
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.pipeline.text = @"";
    [self.brain clearAll];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

@end
