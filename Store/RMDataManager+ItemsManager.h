//
//  RMDataManager+ItemManager.h
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

//successHandler: (void(^) (PixSearchedPhotos *))success

#import "RMDataManager.h"
#import "Item.h"

@interface RMDataManager (ItemsManager)

- (void) writeOrUpdateItems: (NSArray *)items;

- (void) getAllItems:(void(^) (NSArray*))success failHundler:(void(^) (NSString *))fail;

- (RMItem *) getRMItemByArticul:(NSNumber *)articul;


@end
