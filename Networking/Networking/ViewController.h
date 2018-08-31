#import <UIKit/UIKit.h>

@protocol ProductsGateway;

@interface ViewController : UIViewController

@property (strong, nonatomic) id<ProductsGateway> gateway;

- (void)executeGetProducts;
- (void)executeGetProductDetails;
- (void)executeGetImage;

@end

