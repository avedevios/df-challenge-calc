//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>

@interface CalculatorObjC : NSObject

- (void)inputNumber:(double)number;
- (void)setOperation:(NSString *)operation;
- (double)calculate;
- (double)calculateTrigonometric;
- (void)clear;

@end
