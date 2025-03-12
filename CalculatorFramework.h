//
//  CalculatorFramework.h
//  CalculatorFramework
//
//  Created by Anton Averianov on 2025-03-11.
//

#import <Foundation/Foundation.h>

@interface CalculatorFramework : NSObject

- (void)inputNumber:(double)number;
- (void)setOperation:(NSString *)operation;
- (double)calculate;
- (double)calculateTrigonometric;
- (void)clear;

@end
