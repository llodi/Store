//
//  RMDataManager.m
//  Store
//
//  Created by Ilya Dolgopolov on 26.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "RMDataManager.h"

@interface RMDataManager ()


@end

@implementation RMDataManager

+ (id)sharedManager {
    static RMDataManager *sharedManager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager_ = [[self alloc] init];
    });
    return sharedManager_;
}

- (instancetype)init {
    self = [super init];
    
    if(self) {
        [self setVersionAndMigrations];
    }
    return self;
}

- (void)setVersionAndMigrations {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];

    // Set the new schema version. This must be greater than the previously used
    // version (if you've never set a schema version before, the version is 0).
    config.schemaVersion = 2;
    
    // Set the block which will be called automatically when opening a Realm with a
    // schema version lower than the one set above
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automatically
        }
    };
    
    // Tell Realm to use this new configuration object for the default Realm
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    // Now that we've told Realm how to handle the schema change, opening the file
    // will automatically perform the migration
    [RLMRealm defaultRealm];
}

- (dispatch_queue_t) backgroundQueue {
    if(!_backgroundQueue) _backgroundQueue = dispatch_queue_create("RealmBackground", nil);
    return _backgroundQueue;
}

- (void)clearAllData {
    dispatch_async(self.backgroundQueue, ^{
        RLMRealm *realm = [[RLMRealm alloc] init];
        // Delete all objects from the realm
        [realm beginWriteTransaction];
        [realm deleteAllObjects];
        [realm commitWriteTransaction];

    });
}



@end
