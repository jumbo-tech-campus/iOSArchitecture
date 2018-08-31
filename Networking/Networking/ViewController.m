#import "ViewController.h"
#import "Networking-Swift.h"

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.gateway = [UxApiGateway new];

    [self executeGetProducts];
    sleep(3);
    [self executeGetProducts];

    [self executeGetProductDetails];
    [self executeGetImage];
}

- (void)executeGetProducts {
    NSLog(@"\n⛔️ GET PRODUCTS");

    [self.gateway getProductsOnSuccess:^(NSArray<Product *> *products) {
        NSLog(@"Fetched %ld products", (long)products.count);
        [products enumerateObjectsUsingBlock:^(Product *product, NSUInteger idx, BOOL *stop) {
            NSLog(@" - Product %@ - %@", product.identifier, product.title);
        }];

    } onError:^(NSError *error) {
        NSLog(@"Error fetching list: %@", error.localizedDescription);
    }];
}

- (void)executeGetProductDetails {
    NSLog(@"\n⛔️ GET PRODUCT DETAILS");

    Product *product = [[Product alloc] initWithIdentifier:@"17" title:@"fake product"];

    [self.gateway getProductDetails:product onSuccess:^(Product *product) {
        NSLog(@"Fetched product details %@ - %@", product.identifier, product.title);
    } onError:^(NSError *error) {
        NSLog(@"Error fetching details: %@", error.localizedDescription);
    }];
}

- (void)executeGetImage {
    NSLog(@"\n⛔️ GET IMAGE");

    NSString *imageUrl = @"https://www.jumbo.com/INTERSHOP/static/WFS/Jumbo-Grocery-Site/-/Jumbo-Grocery/nl_NL/CMS/Images/2018/Thema/Zomer/Homepage/week-26/Zomer-homepage-wk26-content-Onlinebestellenzondertekst.png";

    [ImageOperation getImageWithUrl:imageUrl onSuccess:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Fetched image!");

            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

            [self.view addSubview:imageView];
        });

    } onError:^(NSError *error) {
        NSLog(@"Error fetching image: %@", error.localizedDescription);
    }];
}

@end
