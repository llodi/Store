//
//  RMDataManager+ItemManager.m
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "RMDataManager+ItemsManager.h"

@implementation RMDataManager (ItemsManager)

- (void) writeOrUpdateItems: (NSArray *) rmItems {
    dispatch_async(self.backgroundQueue, ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObjectsFromArray:[self convertFrom:rmItems]];
        [realm commitWriteTransaction];
    });
}

- (NSArray *) convertFrom: (NSArray *) items {
    NSMutableArray *rmItems = [[NSMutableArray alloc]init];
    for (Item *item in items) {
        [rmItems addObject:[item convert]];
    }
    
    return rmItems;
}

- (void) getAllRMItems:(void(^) (RLMResults<RMItem *>*))success {
    RLMResults<RMItem *> *result = [RMItem allObjects];
    success(result);
}

- (void) getAllItems:(void(^) (NSArray*))success failHundler:(void(^) (NSString *))fail {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self getAllRMItems:^(RLMResults<RMItem *> *rmItems) {
        if (rmItems.count == 0) fail(@"Error to retrieve items from DB");
        for(RMItem *rmItem in rmItems) {
            [result addObject:[[Item alloc] initFromRMItem:rmItem]];
        }
        success(result);
    }];
}


- (RMItem *) getRMItemByArticul:(NSNumber *)articul {
    return [RMItem objectForPrimaryKey:articul];
}



@end
