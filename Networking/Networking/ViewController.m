//
//  ViewController.m
//  Networking
//
//  Created by Ruud Puts on 02/08/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

#import "ViewController.h"
#import "Networking-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    id<RequestGatewayProducing> gatewayFactory = [[RequestGatewayFactory alloc] init];
    
    ProductListGateway *gateway = [gatewayFactory makeProductListGateway];
    [gateway objcExecuteWithCompletion:^(NSArray<Product *> *products) {
        NSLog(@"Fetched %ld products", (long)products.count);
        [products enumerateObjectsUsingBlock:^(Product *product, NSUInteger idx, BOOL *stop) {
            NSLog(@" - Product %@ - %@", product.identifier, product.title);
        }];
    }];

    Product *missingProduct = [[Product alloc] initWithIdentifier:@"17" title:@"fake product"];
    ProductDetailsGateway *detailsGateway = [gatewayFactory makeProductDetailsGatewayFor:missingProduct];
    [detailsGateway objcExecuteWithCompletion:^(Product *product) {
        NSLog(@"Fetched product details %@ - %@", product.identifier, product.title);
    }];
}

@end
