//
//  OrderManager.m
//  Store
//
//  Created by Ilya Dolgopolov on 25.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "OrderManager.h"
#import "ItemManager.h"

@interface OrderManager()

@property (nonatomic) NSMutableArray *orderItems;

@end

@implementation OrderManager

+ (id)sharedManager {
    static OrderManager *sharedManager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager_ = [[self alloc] init];
    });
    return sharedManager_;
}

- (double)totalPrice {
    double total = 0;
    if (self.orderItems.count > 0) {
        for (OrderItem *orderItem in self.orderItems) {
            total += [orderItem totalForItem:[[ItemManager sharedManager] getItemByArticul:orderItem.articul]];
        }
    }
    
    return total;
}

- (NSMutableArray *)orderItems {
    if(!_orderItems) _orderItems = [[NSMutableArray alloc] init];
    return _orderItems;
}

- (void)getOrderItems: (void(^) (NSArray *))success failHundler: (void(^) (NSString *))fail {
    if (self.orderItems.count > 0) {
        success(self.orderItems);
    } else {
        [[RMDataManager sharedManager] getAllOrderItems:^(NSArray * orderItems) {
            self.orderItems = [[NSMutableArray alloc] initWithArray:orderItems];
            success(self.orderItems);
        } failHundler:^(NSString * error) {
            fail(error);
        }];
    }
}

- (void)addOrUpdateOrderItem: (OrderItem *)orderItem {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"articul == %lo", orderItem.articul];
    NSArray *filteredArray = [self.orderItems filteredArrayUsingPredicate:predicate];
    if (filteredArray.count == 0) {
        [self.orderItems addObject:orderItem];
        [[RMDataManager sharedManager] writeOrUpdateOrderItem:orderItem];
        return;
    }
    for (OrderItem *oItem in filteredArray) {
        NSInteger i = [self.orderItems indexOfObject:oItem];
        oItem.quantity = oItem.quantity + orderItem.quantity;
        [self.orderItems replaceObjectAtIndex:i withObject:oItem];
        [[RMDataManager sharedManager] writeOrUpdateOrderItem:orderItem];
    }
}

- (void)changeOrderItemQuantity: (OrderItem *)orderItem {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"articul == %lo", orderItem.articul];
    NSArray *filteredArray = [self.orderItems filteredArrayUsingPredicate:predicate];
    
    if (filteredArray.count == 0) return;
    for (OrderItem *oItem in filteredArray) {
        NSInteger i = [self.orderItems indexOfObject:oItem];
        oItem.quantity = orderItem.quantity;
        [self.orderItems replaceObjectAtIndex:i withObject:oItem];
        [[RMDataManager sharedManager] writeOrUpdateOrderItem:orderItem];
    }
}

- (void)emptyOrder {
    [self.orderItems removeAllObjects];
    [[RMDataManager sharedManager] removeAllRMOrderItems];
}

- (void)removeOrderItem: (OrderItem *)oItem {
    [self.orderItems removeObject:oItem];
    [[RMDataManager sharedManager] removeOrderItemByArticul:[NSNumber numberWithInteger:oItem.articul]];
}


@end
