//
//  ViewController.m
//  StylingEngine
//
//  Created by Ruud Puts on 17/07/2018.
//  Copyright © 2018 Ruud Puts. All rights reserved.
//

#import "ViewController.h"
#import "StylingEngine-Swift.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UILabel *label = [UILabel new];
    [self.view addSubview:label];

    [self.topView styleAs:JMBViewStylePromotionView];
    [self.view styleAs:JMBViewStyleBackgroundView];
    [label styleAs:JMBViewStylePromotionLabel];
    /**
     Or in Swift:
     self.topView.style(as: .promotionView)
     self.view.style(as: .backgroundView)
     label.style(as: .backgroundView)
     **/

    label.text = @"I'm a label, look at me shine 🌟";
    [label sizeToFit];
    label.center = self.view.center;
}

@end
