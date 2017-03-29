//
//  BinViewController.m
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "BinViewController.h"
#import "PurchaseItemDetailsController.h"
#import "OrderPositionCell.h"
#import "ItemManager.h"
#import "NSString+formatter.h"
#import "ItemsQuantityController.h"
#import "TransitorHelper.h"


@interface BinViewController () <UITableViewDataSource, UITableViewDelegate, ItemsQuantity>

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic) TransitorHelper *transitor;

@end

@implementation BinViewController

NSString *const OrderPositionCellId = @"OrderPositionCellId";
NSString *const ShowItemDetails = @"ShowItemDetails2";
NSString *const ShowItemsQuantityControllerSegue2 =  @"ShowItemsQuantityController2";


#pragma mark - Life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Корзина";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.estimatedRowHeight = 45.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(handleUpdateOrder:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getOrderItems];
}


#pragma mark - Actions

- (IBAction)emptyOrderAction:(UIBarButtonItem *)sender {
    [[OrderManager sharedManager] emptyOrder];
    [self updateLabels];
}


#pragma mark - getters/setters

- (UIRefreshControl *)refreshControl {
    if(!_refreshControl) _refreshControl = [[UIRefreshControl alloc] init];
    return _refreshControl;
}

- (void) setOrderItems:(NSArray *)orderItems {
    _orderItems = orderItems;
    [self updateLabels];
}

- (void)updateLabels {
    [self.tableView reloadData];
    self.positionsQuqntityLabel.text = [NSString formateInt:self.orderItems.count];
    self.totalPriceLabel.text = [NSString formateDouble:[[OrderManager sharedManager] totalPrice]];
}

- (TransitorHelper *)transitor {
    if(!_transitor) _transitor = [[TransitorHelper alloc] init];
    return _transitor;
}

#pragma mark - handlers

- (void)handleUpdateOrder: (UIRefreshControl *)refreshControl {
    [self getOrderItems];
    [self updateLabels];
    [refreshControl endRefreshing];
}

- (void) getOrderItems {
   [[OrderManager sharedManager] getOrderItems:^(NSArray * orderItems) {
       self.orderItems = orderItems;
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableView reloadData];
           [self.refreshControl endRefreshing];
       });
       
   } failHundler:^(NSString * error) {
       NSLog(@"%@",error);
   }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.orderItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderPositionCell *cell = (OrderPositionCell *) [tableView dequeueReusableCellWithIdentifier:OrderPositionCellId];

    if (cell) {
        OrderItem *orderItem = (OrderItem *) self.orderItems[indexPath.item];
        if (orderItem) {
            Item *item = [[ItemManager sharedManager] getItemByArticul:orderItem.articul];
            if (item) {
                cell.orderItem = orderItem;
                cell.item = item;
                return cell;
            }
        }
    }
    
    return [[UITableViewCell alloc] init];
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) return 45;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) return self.headerView;
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Удалить" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [[OrderManager sharedManager] removeOrderItem:self.orderItems[indexPath.item]];
        [strongSelf updateLabels];
        delete.backgroundColor = [UIColor redColor];
    }];
    UITableViewRowAction *change = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Изменить" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        OrderItem *item = (OrderItem *) strongSelf.orderItems[indexPath.item];
        change.backgroundColor = [UIColor grayColor];
        if (item) {
            [strongSelf performSegueWithIdentifier:ShowItemsQuantityControllerSegue2 sender:item];
            [strongSelf updateLabels];
        }
    }];
    return @[delete,change];
}

#pragma mark - ItemsQuantity

- (void) getOrderItem:(OrderItem *)orderItem {
    [[OrderManager sharedManager] changeOrderItemQuantity:orderItem];
    [self updateLabels];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:ShowItemDetails]) {
        PurchaseItemDetailsController *pvc = (PurchaseItemDetailsController *) segue.destinationViewController;
        if(pvc) {
            OrderPositionCell *cell = (OrderPositionCell *) sender;
            if (cell) {
                pvc.articul = cell.orderItem.articul;
            }
        }
    } else if ([segue.identifier isEqualToString:ShowItemsQuantityControllerSegue2]) {
        ItemsQuantityController *qvc = (ItemsQuantityController *) segue.destinationViewController;
        if (qvc) {
            OrderItem *item = (OrderItem *)sender;
            if(item) {
                qvc.articul = item.articul;
                qvc.delegate = self;
            }
            [qvc setCurrentValueFrom:item.quantity];
            qvc.modalPresentationStyle = UIModalPresentationCustom;
            self.transitor.options = UICustomTransitionCentrallyOptions;
            qvc.transitioningDelegate = self.transitor;
        }
    }
}

@end
