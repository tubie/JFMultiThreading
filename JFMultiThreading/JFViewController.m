//
//  JFViewController.m
//  JFMultiThreading
//
//  Created by TuBieBuTu on 2018/10/13.
//  Copyright © 2018年 TuBieBuTu. All rights reserved.
//

#import "JFViewController.h"
#import "JFNSThreadVC.h"
#import "JFNSOperationVC.h"
#import "JFNSRunloopVC.h"
#import "JFGCDVC.h"

@interface JFViewController ()

@end

@implementation JFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多线程";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)NSThreadClick:(id)sender {
    JFNSThreadVC *VC = [JFNSThreadVC new];
    [self pushWith:VC];
}

- (IBAction)GCDClick:(id)sender {
    JFGCDVC *VC = [JFGCDVC new];
    [self pushWith:VC];
}

- (IBAction)NSOperationClick:(id)sender {
    JFNSOperationVC *VC = [JFNSOperationVC new];
    [self pushWith:VC];
}


- (IBAction)RunLoopClick:(id)sender {
    JFNSRunloopVC *VC = [JFNSRunloopVC new];
    [self pushWith:VC];
}

-(void)pushWith:(UIViewController *)VC{
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
