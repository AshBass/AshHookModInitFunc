//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#import "TestMacro.h"

NSString *description(const char *str){
    return [NSString stringWithFormat:@"hello %s",str];
}

#define E(str) description(str)


NSString* globalArray[] = {
    E("hello"),
    E("hello"),
    E("hello"),
    E("hello"),
    E("hello"),
    E("hello"),
};

NSString *globalString = E("world");

