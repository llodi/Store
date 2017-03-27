//
//  Item.h
//  Store
//
//  Created by Ilya Dolgopolov on 23.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMItem.h"

@interface Item : NSObject

@property (nonatomic) NSInteger articul;
@property (nonatomic) NSString *stringUrlImagePreview;
@property (nonatomic) NSString *title;
@property (nonatomic) double priceForOne;
@property (nonatomic) NSInteger inBulkQuantity;
@property (nonatomic) double priceInBulk;

- (instancetype) initWithArticul: (NSInteger) articul
                         withUrl: (NSString *) url
                        andTitle: (NSString *) title
                  andPriceForOne: (double) price
                 andInBulkQuantity: (NSInteger) inBulkQuantity
                  andPriceInBulk: (double) priceInBulk;

- (instancetype)initFromRMItem: (RMItem *)item ;

- (RMItem *)convert;

@end
