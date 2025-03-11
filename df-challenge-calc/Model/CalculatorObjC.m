//
//  CalculatorObjC.m
//  df-challenge-calc
//
//  Created by Anton Averianov on 2025-03-09.
//

#import "CalculatorObjC.h"

@interface CalculatorObjC ()
@property (nonatomic, strong) NSNumber *firstNumber;
@property (nonatomic, strong) NSNumber *secondNumber;
@property (nonatomic, strong) NSString *operation;
@end

@implementation CalculatorObjC

- (instancetype)init {
    self = [super init];
    if (self) {
        _firstNumber = nil;
        _secondNumber = nil;
        _operation = nil;
    }
    return self;
}

- (void)inputNumber:(double)number {
    if (!self.operation) {
        self.firstNumber = @(number);
    } else {
        self.secondNumber = @(number);
    }
}

- (void)setOperation:(NSString *)operation {
    if (self.firstNumber) {
        _operation = operation;
    }
}

- (double)calculate {
    if (!self.firstNumber || !self.secondNumber || !self.operation) {
        return NAN;
    }

    double result = 0;
    double num1 = [self.firstNumber doubleValue];
    double num2 = [self.secondNumber doubleValue];

    if ([self.operation isEqualToString:@"+"]) {
        result = num1 + num2;
    } else if ([self.operation isEqualToString:@"-"]) {
        result = num1 - num2;
    } else if ([self.operation isEqualToString:@"×"]) {
        result = num1 * num2;
    } else if ([self.operation isEqualToString:@"÷"]) {
        result = num2 != 0 ? num1 / num2 : NAN;
    }

    self.firstNumber = @(result);
    self.secondNumber = nil;
    self.operation = nil;

    return result;
}

- (double)calculateTrigonometric {
    if (!self.firstNumber || !self.operation) {
        return NAN;
    }

    double result = NAN;
    double num1 = [self.firstNumber doubleValue];

    if ([self.operation isEqualToString:@"sin"]) {
        result = sin(num1);
    } else if ([self.operation isEqualToString:@"cos"]) {
        result = cos(num1);
    } else if ([self.operation isEqualToString:@"tan"]) {
        result = tan(num1);
    }
    
    if (isnan(result)) {
        return NAN;
    }

    self.firstNumber = @(result);
    self.secondNumber = nil;
    self.operation = nil;

    return result;
}

- (void)clear {
    self.firstNumber = nil;
    self.secondNumber = nil;
    self.operation = nil;
}

@end
