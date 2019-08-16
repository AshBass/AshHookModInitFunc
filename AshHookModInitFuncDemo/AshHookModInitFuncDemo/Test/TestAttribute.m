//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//
#import "TestAttribute.h"


__attribute__((constructor)) void myentry(){
    NSLog(@"constructor");
}
