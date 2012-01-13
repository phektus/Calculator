//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Arbie Samong on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;    
- (void)clearAll;
@end
