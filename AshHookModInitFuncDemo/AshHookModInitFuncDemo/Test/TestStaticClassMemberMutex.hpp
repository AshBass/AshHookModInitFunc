//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#ifndef TestStaticClassMemberMutex_hpp
#define TestStaticClassMemberMutex_hpp

#include <thread>

class TestStaticClassMemberMutex{
public:
    
    void hello();
    
private:
    static std::mutex s_mutex;
};

#endif /* TestStaticClassMemberMutex_hpp */
