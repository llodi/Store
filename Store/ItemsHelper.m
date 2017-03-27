//
//  ItemsHelper.m
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "ItemsHelper.h"
#import "Item.h"

@interface ItemsHelper()

@property (nonatomic) NSMutableArray *itemsFromServer;
@property (nonatomic) NSInteger currentPref;

@end

@implementation ItemsHelper

#define ARTICUL_PREF 1000

+ (id)shared {
    static ItemsHelper *shared_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared_ = [[self alloc] init];
    });
    return shared_;
}

- (instancetype) init {
    self = [super init];
    
    if(self) {
        //[self bildItemsArray];
    }
    return self;
}

- (NSMutableArray *) itemsFromServer {
    if(!_itemsFromServer) _itemsFromServer = [[NSMutableArray alloc] init];
    return _itemsFromServer;
}

- (void) bildItemsArray {
    self.currentPref = ARTICUL_PREF;
    [self.itemsFromServer addObject:[[Item alloc]
                      initWithArticul: self.currentPref++
                      withUrl: @"https://mdata.yandex.net/i?path=b0910230234_img_id2130334858748450706.jpg&size=5"
                      andTitle:@"Apple iPhone 5S 16Gb Смартфон, iOS 7 Экран 4', разрешение 1136x640 Камера 8 МП, автофокус, F/2.2  Память 16 Гб, без слота для карт памяти 3G, 4G LTE, Wi-Fi, Bluetooth, GPS, ГЛОНАСС"
                      andPriceForOne:24000.2
                      andInBulkQuantity:10
                      andPriceInBulk:18000.0
                      ]];
    [self.itemsFromServer addObject:[[Item alloc]
                      initWithArticul: self.currentPref++
                      withUrl: @"https://mdata.yandex.net/i?path=b0909190541_img_id421183606100709995.jpeg&size=5"
                      andTitle:@"Apple iPhone 7 32Gb Смартфон, iOS 10 Экран 4.7', разрешение 1334x750 Камера 12 МП, автофокус, F/1.8 Память 32 Гб, без слота для карт памяти"
                      andPriceForOne:65450
                      andInBulkQuantity:10
                      andPriceInBulk:37990
                      ]];
    [self.itemsFromServer addObject:[[Item alloc]
                      initWithArticul: self.currentPref++
                      withUrl: @"https://mdata.yandex.net/i?path=b1212235556_img_id8562898701803224435.jpeg&size=5"
                      andTitle:@"Xiaomi Redmi 4 Prime Смартфон, Android 6.0 Поддержка двух SIM-карт Экран 5', разрешение 1920x 1080 Камера 13 МП, автофокус, F/2.2"
                      andPriceForOne:16990
                      andInBulkQuantity:3
                      andPriceInBulk:10990.0
                      ]];
    [self.itemsFromServer addObject:[[Item alloc]
                      initWithArticul: self.currentPref++
                      withUrl: @"https://mdata.yandex.net/i?path=b0110231455_img_id3002499005923416015.jpeg&size=5"
                      andTitle:@"Samsung Galaxy A5 (2017) SM-A520F Смартфон на платформе Android Поддержка двух SIM-карт Экран 5.2', разрешение 1920x1080 Камера 16 МП, автофокус, F/1.9"
                      andPriceForOne:29990
                      andInBulkQuantity:3
                      andPriceInBulk:19890.0
                      ]];
    [self.itemsFromServer addObject:[[Item alloc]
                      initWithArticul: self.currentPref++
                      withUrl: @"https://mdata.yandex.net/i?path=b0412204036_img_id8001944525667652592.jpeg&size=5"
                      andTitle:@"Meizu M3 Note 32Gb Смартфон, Android 5.1 Поддержка двух SIM-карт Экран 5.5', разрешение 1920x1080 Камера 13 МП, автофокус, F/2.2"
                      andPriceForOne:29990
                      andInBulkQuantity:3
                      andPriceInBulk:19890.0
                      ]];
    [self.itemsFromServer addObject:[[Item alloc]
                      initWithArticul: self.currentPref++
                      withUrl: @"https://mdata.yandex.net/i?path=b0511175441_img_id8063985976867472920.jpeg&size=5"
                      andTitle:@"Huawei P9 Lite Смартфон, Android 6.0 Поддержка двух SIM-карт Экран 5.2', разрешение 1920x1080 Камера 13 МП, автофокус"
                      andPriceForOne:19990
                      andInBulkQuantity:13
                      andPriceInBulk:13540.0
                      ]];
}

- (NSArray *) getItemsFromServer {
    return self.itemsFromServer;
}

@end
