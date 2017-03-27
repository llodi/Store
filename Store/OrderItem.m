//
//  OrderItem.m
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem


- (instancetype) initWithArticul: (NSInteger) articul withQuantity: (NSInteger) quantity {
    self = [super init];
    
    if(self) {
        self.articul = articul;
        self.quantity = quantity;
    }
    
    return self;
}

- (instancetype)initFrom: (RMOrderItem *)rmOrderItem {
    self = [super init];
    
    if(self) {
        self.articul = rmOrderItem.articul;
        self.quantity = rmOrderItem.quantity;
    }
    return self;
}

- (RMOrderItem *) convert {
    RMOrderItem *rmOrderItem = [[RMOrderItem alloc] init];
    rmOrderItem.articul = self.articul;
    rmOrderItem.quantity = self.quantity;
    return rmOrderItem;
}


- (double) totalForItem: (Item *)item {
    return self.quantity <= item.inBulkQuantity ? self.quantity * item.priceForOne : self.quantity * item.priceInBulk;
}


@end
