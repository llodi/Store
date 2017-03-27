//
//  ItemsHelper.h
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsHelper : NSObject

+ (id)shared;

- (NSArray *) getItemsFromServer ;

@end

