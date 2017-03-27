//
//  RMOrderItem.h
//  Store
//
//  Created by Ilya on 27.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Realm/Realm.h>

@interface RMOrderItem : RLMObject

@property (nonatomic) NSInteger articul;
@property (nonatomic) NSInteger quantity;

@end
RLM_ARRAY_TYPE(RMOrderItem)
