//
//  ViewController.m
//  RFStoreDemo
//
//  Created by 便便出行 on 2019/1/22.
//  Copyright © 2019 bbcx. All rights reserved.
//

#import "ViewController.h"

#import "RFHomePageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"RFDemo";
}

- (IBAction)buttonClick:(id)sender {
    
    RFHomePageViewController *vc = [RFHomePageViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
