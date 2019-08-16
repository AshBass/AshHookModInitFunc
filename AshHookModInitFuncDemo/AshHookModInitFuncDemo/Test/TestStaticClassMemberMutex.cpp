//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#include "TestStaticClassMemberMutex.hpp"


std::mutex TestStaticClassMemberMutex::s_mutex;


void TestStaticClassMemberMutex::hello(){
    s_mutex.lock();
    
    s_mutex.unlock();
}
