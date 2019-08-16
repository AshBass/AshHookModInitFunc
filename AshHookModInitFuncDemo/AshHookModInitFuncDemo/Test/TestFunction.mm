//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#import "TestFunction.h"

bool initBar(){
    int i = 0;
    ++i;
    return i == 1;
}


//bool globalBar2 = initBar();

void hello(){
    
    static bool globalBar = initBar();
    
    NSLog(@"%@",@(globalBar));
}
