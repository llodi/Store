//
//  NSString+formatter.h
//  Store
//
//  Created by Ilya Dolgopolov on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (formatter)

+ (NSString *) formateDouble: (double) _double ;
+ (NSString *) formateInt: (NSInteger) _int ;

@end
