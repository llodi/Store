//
//  ItemsQuantityController.m
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "ItemsQuantityController.h"

@interface ItemsQuantityController()

@property (weak, nonatomic) IBOutlet UIStepper *stepperOutlet;

@property (nonatomic) double currentValue;

@end


@implementation ItemsQuantityController

@synthesize currentValue = _currentValue;

- (double) currentValue {
    if (!_currentValue) _currentValue = 1.0;
    return _currentValue;
}

- (void) setCurrentValue:(double)currentValue {
    _currentValue = currentValue;
    self.quantityLabel.text = [NSString stringWithFormat:@"%.0f",_currentValue];
    //[self.delegate getQx§uantity:(NSInteger)_currentValue forItem:self.item];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.quantityLabel.text = [NSString stringWithFormat:@"%.0f",self.currentValue];
    self.stepperOutlet.value = self.currentValue;
    
    self.view.layer.cornerRadius = 15;
    self.view.layer.masksToBounds = YES;
}

- (IBAction)okAction:(UIButton *)sender {
    [self.delegate getOrderItem:[[OrderItem alloc] initWithArticul:self.articul withQuantity:self.currentValue]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)stepperAction:(UIStepper *)sender {
        self.currentValue = sender.value;
}

- (void) setCurrentValueFrom: (double) value {
    self.currentValue = value;
    self.stepperOutlet.value = value;
}


@end
