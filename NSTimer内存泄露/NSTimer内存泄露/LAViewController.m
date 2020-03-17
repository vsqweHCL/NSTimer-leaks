//
//  LAViewController.m
//  NSTimer内存泄露
//
//  Created by xuzhiyong on 2020/3/17.
//  Copyright © 2020 xxx. All rights reserved.
//

#import "LAViewController.h"
#import "LATimerTarget.h"

@interface LAViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSTimer *timer;
@end

static NSInteger TimerInteger = 0;

@implementation LAViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    /**
     不能在viewDidDisappear移除，因为当我们push到下一个页面的时候，定时器就没了
     再处理起来就很麻烦
     */
//    [self removeTimer];
}

- (void)dealloc {
    NSLog(@"dealloc");
    [self removeTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.label = [[UILabel alloc] init];
    self.label.backgroundColor = [UIColor greenColor];
    self.label.font = [UIFont systemFontOfSize:20];
    self.label.frame = CGRectMake(0, 100, 200, 100);
    [self.view addSubview:self.label];
    
    /**
     当target为self的时候，退出该控制器时，dealloc是不会调用的，这会导致内存泄露
     */
//    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    /**
     target设置为LATimerTarget对象，并且在LATimerTarget新增timerTargetAction方法
     通过targetBlock回调，进行UI逻辑处理
     这个时候我们退出该控制器时，dealloc调用，移除定时器
     */
    LATimerTarget *target = [[LATimerTarget alloc] init];
    __weak __typeof(&*self)weakSelf = self;
    target.targetBlock = ^{
        TimerInteger += 1;
        weakSelf.label.text = @(TimerInteger).stringValue;
    };
    self.timer = [NSTimer timerWithTimeInterval:1 target:target selector:@selector(timerTargetAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction {
    NSLog(@"timerAction");
    TimerInteger += 1;
    self.label.text = @(TimerInteger).stringValue;
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}
@end
