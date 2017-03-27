//
//  OrderItem.h
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "RMOrderItem.h"

@interface OrderItem : NSObject

@property (nonatomic) NSInteger articul;
@property (nonatomic) NSInteger quantity;
//@property (nonatomic, readonly) double totalForItem;

- (double) totalForItem: (Item *)item;

- (instancetype) initWithArticul: (NSInteger) articul withQuantity: (NSInteger) quantity;

- (instancetype)initFrom: (RMOrderItem *)rmOrderItem;

- (RMOrderItem *) convert;

@end
