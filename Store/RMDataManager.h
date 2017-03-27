//
//  RMDataManager.h
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RMDataManager : NSObject

@property (nonatomic) dispatch_queue_t backgroundQueue;

+ (id)sharedManager;

- (void)clearAllData;


@end
