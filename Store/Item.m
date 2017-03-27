//
//  Item.m
//  Store
//
//  Created by Ilya Dolgopolov on 23.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype) initWithArticul: (NSInteger) articul
                         withUrl: (NSString *) url
                        andTitle: (NSString *) title
                  andPriceForOne: (double) priceForOne
                 andInBulkQuantity: (NSInteger) inBulkQuantity
                  andPriceInBulk: (double) priceInBulk
{
    self = [super init];
    
    if(self) {
        self.articul = articul;
        self.stringUrlImagePreview = url;
        self.title = title;
        self.priceForOne = priceForOne;
        self.inBulkQuantity = inBulkQuantity;
        self.priceInBulk = priceInBulk;
    };
    return self;
};

- (instancetype)initFromRMItem: (RMItem *)item {
    self = [super self];
    if (self) {
        self.articul = item.articul;
        self.stringUrlImagePreview = item.stringUrlImagePreview;
        self.title = item.title;
        self.priceForOne = item.priceForOne;
        self.inBulkQuantity = item.inBulkQuantity;
        self.priceInBulk = item.priceInBulk;
    }
    return self;
}

- (RMItem *)convert {
    RMItem *rmItem = [[RMItem alloc] init];
    
    rmItem.articul = self.articul;
    rmItem.stringUrlImagePreview = self.stringUrlImagePreview;
    rmItem.title = self.title;
    rmItem.priceForOne = self.priceForOne;
    rmItem.inBulkQuantity = self.inBulkQuantity;
    rmItem.priceInBulk = self.priceInBulk;
    
    return rmItem;
}

@end
