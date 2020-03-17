//
//  LATimerTarget.h
//  NSTimer内存泄露
//
//  Created by xuzhiyong on 2020/3/17.
//  Copyright © 2020 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LATimerTarget : NSObject

@property (nonatomic, copy) void(^targetBlock)(void);

- (void)timerTargetAction;

@end

NS_ASSUME_NONNULL_END
