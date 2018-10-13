//
//  JFNSThreadViewController.m
//  JFMultiThreading
//
//  Created by TuBieBuTu on 2018/10/13.
//  Copyright © 2018年 TuBieBuTu. All rights reserved.
//

#import "JFNSThreadViewController.h"

@interface JFNSThreadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,assign)NSInteger ticketSurplusCount;

@end

@implementation JFNSThreadViewController

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
    
    [self downloadImageOnChildThread];
    
//    [self initTicketStatusNotSave];
    
    [self initTicketStatusSave];
    
    // Do any additional setup after loading the view from its nib.
}

// 新线程调用方法，里边为需要执行的任务
- (void)run {
    NSLog(@"%@", [NSThread currentThread]);
}

/**
 * 创建一个线程下载图片
 */
- (void)downloadImageOnChildThread {
    // 在创建的子线程中调用downloadImage下载图片
    [NSThread detachNewThreadSelector:@selector(downloadImage) toTarget:self withObject:nil];
}

/**
 * 下载图片，下载完之后回到主线程进行 UI 刷新
 */
- (void)downloadImage {
    NSLog(@"current thread -- %@", [NSThread currentThread]);
    
    // 1. imageUrl URL格式化
    NSURL *imageUrl = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539450809191&di=eed853766615f765d622e08803b4e8a9&imgtype=0&src=http%3A%2F%2Ffile03.16sucai.com%2F2017%2F1100%2F16sucai_p20161106032_0c2.JPG"];
    
    // 2. 从 imageUrl 中读取数据(下载图片)
    //-- 耗时操作
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    // 通过二进制 data 创建 image
    UIImage *image = [UIImage imageWithData:imageData];
    
    
    // 3. 回到主线程进行图片赋值和界面刷新
    [self performSelectorOnMainThread:@selector(refreshOnMainThread:) withObject:image waitUntilDone:YES];
}

/**
 * 回到主线程进行图片赋值和界面刷新
 */
- (void)refreshOnMainThread:(UIImage *)image {
    // 赋值图片到imageview
    self.imageView.image = image;
}


/**
 * 初始化体育彩票票数量、卖票窗口(非线程安全)、并开始卖票
 */
- (void)initTicketStatusNotSave {
    // 1. 设置剩余火车票为 50
    self.ticketSurplusCount = 50;
    
    // 2. 篮球彩票票票窗口的线程
    NSThread  *salebBasketballWindow  = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    salebBasketballWindow.name = @"篮球彩票票票窗口";
    
    // 3. 足球彩票售票窗口的线程
    NSThread  *salebFootballWindow = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    salebFootballWindow.name = @"足球彩票售票窗口";
    
    // 4. 开始售卖体育彩票
    [salebBasketballWindow start];
    [salebFootballWindow start];
    
}

/**
 * 售卖体育彩票(非线程安全)
 */
- (void)saleTicketNotSafe {
    while (1) {
        //如果还有票，继续售卖
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount --;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount, [NSThread currentThread].name]);
            [NSThread sleepForTimeInterval:0.2];
        }
        //如果已卖完，关闭售票窗口
        else {
            NSLog(@"所有彩票均已售完");
            break;
        }
    }
}


/**
 * 初始化体育彩票票数量、卖票窗口(非线程安全)、并开始卖票
 */
- (void)initTicketStatusSave {
    // 1. 设置剩余火车票为 50
    self.ticketSurplusCount = 50;
    
    // 2. 篮球彩票票票窗口的线程
    NSThread  *salebBasketballWindow  = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    salebBasketballWindow.name = @"篮球彩票票票窗口";
    
    // 3. 足球彩票售票窗口的线程
    NSThread  *salebFootballWindow = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    salebFootballWindow.name = @"足球彩票售票窗口";
    
    // 4. 开始售卖体育彩票
    [salebBasketballWindow start];
    [salebFootballWindow start];
    
}

/**
 * (线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        // 互斥锁
        @synchronized (self) {
            //如果还有票，继续售卖
            if (self.ticketSurplusCount > 0) {
                self.ticketSurplusCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                NSLog(@"所有彩票均已售完");
                break;
            }
        }
    }
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
