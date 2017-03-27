//
//  RMDataManager+OrderManager.m
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "RMDataManager+OrderManager.h"

@implementation RMDataManager (OrderManager)

- (void) writeOrUpdateOrderItem: (OrderItem *)orderItem {
    dispatch_async(self.backgroundQueue, ^{
        RMOrderItem *rmOrderItem = [orderItem convert];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:rmOrderItem];
        [realm commitWriteTransaction];
    });
}

- (NSArray *) convertFrom: (NSArray *) items {
    NSMutableArray *rmItems = [[NSMutableArray alloc]init];
    for (OrderItem *item in items) {
        [rmItems addObject:[item convert]];
    }
    return rmItems;
}

- (RLMResults<RMOrderItem *> *) getAllRMOrderItems {
    return [RMOrderItem allObjects];
}

- (void) getAllOrderItems:(void(^) (NSArray*))success failHundler:(void(^) (NSString *))fail {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    RLMResults<RMOrderItem *> *rmOrderItems = [self getAllRMOrderItems];
    
    for(RMOrderItem *rmItem in rmOrderItems) {
        [result addObject:[[OrderItem alloc] initFrom:rmItem]];
    }
    if(result) {
        success(result);
    } else {
        fail(@"Error when retrieving rmOrderItems from DB");
    }
    
}

- (void) removeAllRMOrderItems {
    dispatch_async(self.backgroundQueue, ^{
        RLMResults<RMOrderItem *> *rmOrderItems = [self getAllRMOrderItems];
        if(rmOrderItems.count == 0) return;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObjects:rmOrderItems];
        [realm commitWriteTransaction];
    });
}

- (RMOrderItem *) getRMOrderItemByArticul:(NSNumber *)articul {
    return [RMOrderItem objectForPrimaryKey:articul];
}

- (void) removeOrderItemByArticul: (NSNumber *)articul {
    dispatch_async(self.backgroundQueue, ^{
        RMOrderItem *rmItem = [RMOrderItem objectForPrimaryKey:articul];
        if(!rmItem) return;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject: rmItem];
        [realm commitWriteTransaction];
    });
}


@end
