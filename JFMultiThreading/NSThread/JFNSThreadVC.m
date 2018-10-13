//
//  JFNSThreadVC.m
//  JFMultiThreading
//
//  Created by TuBieBuTu on 2018/10/13.
//  Copyright © 2018年 TuBieBuTu. All rights reserved.
//

#import "JFNSThreadVC.h"

@interface JFNSThreadVC ()

@end

@implementation JFNSThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSThread";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 1. 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    // 2. 启动线程
    [thread start];    // 线程一启动，就会在线程thread中执行self的run方法
    
    /*
     NSThread  *thread = [[NSThread alloc]init];
     NSThread  *thread = [[NSThread alloc]initWithBlock:^{
     NSLog(@"thread");
     }];
     */
    
    //设置线程名字
    [thread setName:@"thread - 1"];
    //设置线程优先级
    [thread setThreadPriority:1.0];
    //IOS 8 之后 推荐使用下面这种方式设置线程优先级
    //NSQualityOfServiceUserInteractive：最高优先级，用于用户交互事件
    //NSQualityOfServiceUserInitiated：次高优先级，用于用户需要马上执行的事件
    //NSQualityOfServiceDefault：默认优先级，主线程和没有设置优先级的线程都默认为这个优先级
    //NSQualityOfServiceUtility：普通优先级，用于普通任务
    //NSQualityOfServiceBackground：最低优先级，用于不重要的任务
    [thread setQualityOfService:NSQualityOfServiceUtility];
    //判断线程是否是主线程
    [thread isMainThread];
    //线程状态
    //是否已经取消
    [thread isCancelled];
    //是否已经结束
    [thread isFinished];
    //是否正在执行
    [thread isExecuting];
    
   
    
    
    
    // 1. 创建线程后自动启动线程
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    
    // 1. 隐式创建并启动线程
    [self performSelectorInBackground:@selector(run) withObject:nil];
    
    // Do any additional setup after loading the view.
}

// 新线程调用方法，里边为需要执行的任务
- (void)run {
    NSLog(@"%@", [NSThread currentThread]);
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
