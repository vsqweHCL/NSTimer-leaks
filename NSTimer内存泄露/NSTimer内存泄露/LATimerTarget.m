//
//  LATimerTarget.m
//  NSTimer内存泄露
//
//  Created by xuzhiyong on 2020/3/17.
//  Copyright © 2020 xxx. All rights reserved.
//

#import "LATimerTarget.h"

@implementation LATimerTarget

- (void)timerTargetAction {
    NSLog(@"timerTargetAction");
    if (self.targetBlock) {
        self.targetBlock();
    }
}
@end
