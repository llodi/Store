//
//  ItemManager.m
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "ItemManager.h"
#import "ItemsHelper.h"
#import "RMDataManager+ItemsManager.h"

@implementation ItemManager

+ (id)sharedManager {
    static ItemManager *sharedManager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager_ = [[self alloc] init];
    });
    return sharedManager_;
}

- (Item *)getItemByArticul: (NSInteger)articul
{
    NSArray *items = [[ItemsHelper shared] getItemsFromServer];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"articul == %lo", articul];
    NSArray *filteredArray = [items filteredArrayUsingPredicate:predicate];
    
    Item *item = [filteredArray firstObject];
    if (item) {
        return item;
    } else {
        return [[Item alloc] initFromRMItem:
                [[RMDataManager sharedManager] getRMItemByArticul:
                 [NSNumber numberWithInteger:articul]]];
         
    }
    
}

- (void) getItems: (void(^) (NSArray *))success failHundler: (void(^) (NSString *))fail {
    NSArray *items = [[ItemsHelper shared] getItemsFromServer];
    
    if (items.count > 0) {
        success(items);
        [[RMDataManager sharedManager] writeOrUpdateItems:items];
    }
    else {
        [[RMDataManager sharedManager] getAllItems:^(NSArray * items) {
            success(items);
        } failHundler:^(NSString * error) {
            fail(error);
        }];
    }
}



@end
