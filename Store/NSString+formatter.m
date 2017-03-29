//
//  NSString+formatter.m
//  Store
//
//  Created by Ilya Dolgopolov on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "NSString+formatter.h"

@implementation NSString (formatter)
+ (NSString *) formateDouble: (double) _double {
    
    NSNumberFormatter *numberFormat = [[NSNumberFormatter alloc] init];
    numberFormat.usesGroupingSeparator = YES;
    numberFormat.groupingSeparator = @" ";
    numberFormat.groupingSize = 3;
    numberFormat.maximumFractionDigits = 2;
    
    NSNumber *doubleNumber = [NSNumber numberWithDouble:_double];
    
    return [self stringWithFormat:@"%@", [numberFormat stringFromNumber: doubleNumber]];
}

+ (NSString *) formateInt: (NSInteger) _int {
    return [self stringWithFormat:@"%ld", _int];
}

//+ (double) getDouble: (double) double_ {
//    NSNumberFormatter *numberFormat = [[NSNumberFormatter alloc] init];
//    
//    NSNumber *doubleNumber = [NSNumber numberWithDouble:_double];
//}

@end
