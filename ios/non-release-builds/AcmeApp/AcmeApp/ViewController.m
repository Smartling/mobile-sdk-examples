//
//  ViewController.m
//  AcmeApp
//
//  Created by Scott Rossillo on 8/21/18.
//  Copyright © 2018 Smartling, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak) IBOutlet UILabel *label;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = NSLocalizedString(@"LABEL_TEXT", nil);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
