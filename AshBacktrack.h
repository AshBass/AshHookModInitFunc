//
//  AshBacktrack.h
//  FishhookDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AshBacktrack : NSObject

/// backCount 默认是100
+(void)setBackCount:(NSUInteger)backCount;
+(void)threadBacktrack;

@end
