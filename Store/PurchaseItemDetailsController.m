//
//  PurchaseItemDetailsController.m
//  Store
//
//  Created by Ilya Dolgopolov on 23.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "PurchaseItemDetailsController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+formatter.h"
#import "Item.h"
#import "ItemManager.h"


@interface PurchaseItemDetailsController ()

@property (nonatomic) Item *item;

@end

@implementation PurchaseItemDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Детали";
    
    [self updateUI];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateUI {
    if(!self.articul) return;
    
    self.item = [[ItemManager sharedManager] getItemByArticul:self.articul];
    
    if(!self.item) return;
    
    NSURL *url = [[NSURL alloc] initWithString:self.item.stringUrlImagePreview];
    if(url) {
        [self.itemImageView sd_setImageWithURL:url];
    }
    self.descriptionLabel.text = self.item.title;
    self.priceForOneLabel.text = [NSString formateDouble:self.item.priceForOne];
    self.quantityInBulk.text = [NSString formateInt:self.item.inBulkQuantity];
    self.priceInBulk.text = [NSString formateDouble:self.item.priceInBulk];
}

//#pragma mark - Table view delegate
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.item == 0) {
        
        CGFloat width = self.view.bounds.size.width;
        CGFloat height = self.view.bounds.size.height;
        
        if (height > width) {
            return width;
        } else {
            return height - 100;
        }
    } if (indexPath.section == 1 && indexPath.item == 0) {
        return 100;
    } else {
        CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
        return height;
    }
    
    return 70;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


@end
