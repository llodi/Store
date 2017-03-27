//
//  ItemManager.h
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ItemManager : NSObject

+ (id)sharedManager;

- (void)getItems: (void(^) (NSArray *))success
     failHundler: (void(^) (NSString *))fail ;

- (Item *)getItemByArticul: (NSInteger)articul;

@end
