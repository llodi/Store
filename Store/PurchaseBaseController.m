//
//  PurchaseBaseController.m
//  Store
//
//  Created by Ilya Dolgopolov on 23.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "PurchaseBaseController.h"
#import "PurchaseItemDetailsController.h"
#import "PurchaseCell.h"
#import "ItemsHelper.h"
#import "Item.h"
#import "BinViewController.h"
#import "ItemsQuantityController.h"
#import "TransitorHelper.h"
#import "OrderItem.h"
#import "OrderManager.h"
#import "ItemManager.h"
#import "RMItem.h"

@interface PurchaseBaseController () <UITableViewDataSource, UITableViewDelegate, ItemsQuantity>

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) NSTimer *statusViewTimer;
@property (nonatomic) TransitorHelper *transitor;

@end

@implementation PurchaseBaseController

#define STATUS_VIEW_DURATION 0.35
NSString *const PurchaseCellId = @"PurchaseCellId";
NSString *const ShowItemDetailsSegue = @"ShowItemDetails";
NSString *const ShowBinSegue = @"ShowBin";
NSString *const ShowItemsQuantityControllerSegue =  @"ShowItemsQuantityController";


#pragma mark - properties getters/setters

- (TransitorHelper *)transitor {
    if(!_transitor) _transitor = [[TransitorHelper alloc] initWithOptions: UICustomTransitionCentrallyOptions
                                                         horizontalInsets:10.0
                                                               hiewHeight:160];
    return _transitor;
}

- (UIRefreshControl *)refreshControl {
    if(!_refreshControl) _refreshControl = [[UIRefreshControl alloc] init];
    return _refreshControl;
}

# pragma mark - Model updater

-(void)loadData {
    [[ItemManager sharedManager] getItems:^(NSArray * items) {
        self.items = items;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.refreshControl endRefreshing];
            [strongSelf.tableView reloadData];
        });
    } failHundler:^(NSString * error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Купить";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.statusView.alpha = 0;
    self.statusView.layer.cornerRadius = 15;
    self.statusView.layer.masksToBounds = YES;
    
    [self.refreshControl addTarget:self action:@selector(handleUpdateModel:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self loadData];
    
//    RMItem *test = [[RMItem alloc]init];
//    test.articul = 10001;
//    test.stringUrlImagePreview = @"";
//    test.title = @"Test";
//    test.priceForOne = 10000;
//    test.inBulkQuantity = 5;
//    test.priceInBulk = 9000;
//    
//    NSLog(@"Name of test: %@", test.title);
}

#pragma mark - selector handlers

- (void)handleUpdateModel: (UIRefreshControl *)refreshControl {
    [self loadData];
    [refreshControl endRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PurchaseCell *cell = (PurchaseCell *) [tableView dequeueReusableCellWithIdentifier:PurchaseCellId];
    
    if (cell) {
        Item *item = (Item *) self.items[indexPath.item];
        if (item) {
            cell.item = item;
            return cell;
        }
    }
    
    return [[UITableViewCell alloc] init];
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *add = [UITableViewRowAction
                                  rowActionWithStyle:UITableViewRowActionStyleDefault
                                  title:@"Добавить"
                                  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      Item *item = (Item *) strongSelf.items[indexPath.item];
                                      if (item) {
                                          [strongSelf performSegueWithIdentifier:ShowItemsQuantityControllerSegue sender:item];
                                          [strongSelf.tableView setEditing:NO animated:YES];
                                      }
                                  }];
    add.backgroundColor = [UIColor redColor];
    return @[add];
}

#pragma mark - Animations

- (void) showStatusView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:STATUS_VIEW_DURATION animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.statusView.hidden = NO;
        strongSelf.statusView.alpha = 1;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.statusViewTimer = [NSTimer
                                scheduledTimerWithTimeInterval:STATUS_VIEW_DURATION
                                target:strongSelf
                                selector:@selector(hideStatusView)
                                userInfo:nil
                                repeats:NO];

    }];
}

- (void) hideStatusView {
    
    if (!self.statusViewTimer) {
        [self.statusViewTimer invalidate];
        self.statusViewTimer = nil;
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:STATUS_VIEW_DURATION
    animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.statusView.alpha = 0;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.statusView.hidden = YES;
    }];
}


#pragma mark - ItemsQuantity

- (void) getOrderItem:(OrderItem *)orderItem {
    [[OrderManager sharedManager] addOrUpdateOrderItem:orderItem];
    [self showStatusView];
}

//- (void) getItemsQuantity:(NSInteger)quantity forArticul:(NSInteger)artcul {
//    NSLog(@"for artcule %lo amount are %lo",artcul, quantity);
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:ShowBinSegue]) {
//        BinViewController *bvc = (BinViewController *)segue.destinationViewController;
//        NSArray *orderItems = [[OrderManager sharedManager] getOrderItems];
//        if (orderItems.count > 0) {
//            bvc.orderItems = orderItems;
//        }
    } else if ([segue.identifier isEqualToString:ShowItemsQuantityControllerSegue]) {
        ItemsQuantityController *qvc = (ItemsQuantityController *) segue.destinationViewController;
        if (qvc) {
            Item *item = (Item *)sender;
            if(item) {
                qvc.articul = item.articul;
                qvc.delegate = self;
            }
            qvc.modalPresentationStyle = UIModalPresentationCustom;
            qvc.transitioningDelegate = self.transitor;
        }
    } else if([segue.identifier isEqualToString:ShowItemDetailsSegue]) {
        PurchaseItemDetailsController *pvc = (PurchaseItemDetailsController *) segue.destinationViewController;
        if(pvc) {
            PurchaseCell *cell = (PurchaseCell *)sender;
            if(cell) {
                pvc.articul = cell.item.articul;
            }
        }
    }
}


@end
