//
//  ViewController.m
//  NSTimer内存泄露
//
//  Created by xuzhiyong on 2020/3/17.
//  Copyright © 2020 xxx. All rights reserved.
//

#import "ViewController.h"
#import "LAViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pushAction:(id)sender {
    LAViewController *vc = [[LAViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
