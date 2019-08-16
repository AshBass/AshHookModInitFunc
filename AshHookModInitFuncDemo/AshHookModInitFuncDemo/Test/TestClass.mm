//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#import "TestClass.h"

class FooObject{
public:
    FooObject(){
        // do somthing
        NSLog(@"in fooobject");
    }
    
};

static FooObject globalObj = FooObject();
FooObject globalObj2 = FooObject();
