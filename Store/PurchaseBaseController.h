//
//  PurchaseBaseController.h
//  Store
//
//  Created by Ilya Dolgopolov on 23.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseBaseController : UIViewController

@property (nonatomic) NSArray *items;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *statusView;



@end
