//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Arbie Samong on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack {
    // singleton with lazy instantiation
    if(_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)setOperandStack:(NSMutableArray *)operandStack {
    _operandStack = operandStack;
}

- (void)pushOperand:(double)operand {
    // push number to the stack as a number object
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation {
    double result = 0;
    
    // calculate result
    if([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if([@"-" isEqualToString:operation]) {
        result = [self popOperand] - [self popOperand];
    } else if([operation isEqualToString:@"/"]) {
        double dividend = [self popOperand];
        if(dividend != 0) {
            result = [self popOperand] / dividend;
        } else {
            result = dividend;
        }
    } else if([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    } else if([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    } else if([operation isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    } else if([operation isEqualToString:@"π"]) {
        [self popOperand];
        result = 3.14159265;
    }
    return result;
}

- (void)clearAll {
    [self.operandStack removeAllObjects];
}

@end
