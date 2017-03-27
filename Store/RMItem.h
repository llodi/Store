//
//  RMItem.h
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Realm/Realm.h>

@interface RMItem : RLMObject

@property (nonatomic) NSInteger articul;
@property (nonatomic) NSString *stringUrlImagePreview;
@property (nonatomic) NSString *title;
@property (nonatomic) double priceForOne;
@property (nonatomic) NSInteger inBulkQuantity;
@property (nonatomic) double priceInBulk;

@end
RLM_ARRAY_TYPE(RMItem)
