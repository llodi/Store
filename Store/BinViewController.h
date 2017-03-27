//
//  BinViewController.h
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderManager.h"


@interface BinViewController : UIViewController

@property (nonatomic) NSArray *orderItems;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *positionsQuqntityLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;


@end
