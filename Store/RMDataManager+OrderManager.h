//
//  RMDataManager+OrderManager.h
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "RMDataManager.h"
#import "OrderItem.h"

@interface RMDataManager (OrderManager)


- (void) writeOrUpdateOrderItem: (OrderItem *)item;

- (void) getAllOrderItems:(void(^) (NSArray*))success failHundler:(void(^) (NSString *))fail;

- (void) removeAllRMOrderItems;
- (void) removeOrderItemByArticul: (NSNumber *)articul;

@end
