//
//  OrderManager.h
//  Store
//
//  Created by Ilya Dolgopolov on 25.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h"
#import "RMDataManager+OrderManager.h"


@interface OrderManager : NSObject

@property (nonatomic,readonly) double totalPrice;

+ (id)sharedManager;

- (void)getOrderItems: (void(^) (NSArray *))success failHundler: (void(^) (NSString *))fail ;

- (void)addOrUpdateOrderItem: (OrderItem *)item;
- (void)changeOrderItemQuantity: (OrderItem *)orderItem;

- (void)removeOrderItem: (OrderItem *)item;

- (void)emptyOrder;

@end
