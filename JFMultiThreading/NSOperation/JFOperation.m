//
//  JFOperation.m
//  JFMultiThreading
//
//  Created by TuBieBuTu on 2018/10/26.
//  Copyright © 2018年 TuBieBuTu. All rights reserved.
//

#import "JFOperation.h"

@implementation JFOperation
/**
 重写mian方法
 */
- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}
@end
