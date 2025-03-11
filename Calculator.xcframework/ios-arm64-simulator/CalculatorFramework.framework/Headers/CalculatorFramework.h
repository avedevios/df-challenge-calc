//
//  CalculatorFramework.h
//  CalculatorFramework
//
//  Created by Anton Averianov on 2025-03-09.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT @interface CalculatorObjC : NSObject

- (void)inputNumber:(double)number;
- (void)setOperation:(NSString *)operation;
- (double)calculate;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
