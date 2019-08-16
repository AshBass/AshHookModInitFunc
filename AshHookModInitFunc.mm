//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#import "AshBacktrack.h"

#import <Foundation/Foundation.h>
#include <unistd.h>
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#include <vector>

static NSTimeInterval sSumInitTime;

using namespace std;

#ifndef __LP64__
typedef uint32_t uint_t;
#else /* defined(__LP64__) */
typedef uint64_t uint_t;
#endif /* defined(__LP64__) */


static std::vector<uint_t> *initFuncVector;
static int vectorIndex;

struct AshProgramVars
{
    const void*        mh;
    int*            NXArgcPtr;
    const char***    NXArgvPtr;
    const char***    environPtr;
    const char**    __prognamePtr;
};

typedef void (*OriginalInitFunc)(int argc, const char* argv[], const char* envp[], const char* apple[], const AshProgramVars* vars);

void AshInitFunc(int argc, const char* argv[], const char* envp[], const char* apple[], const struct AshProgramVars* vars){
//    printf("my init func\n");
//    printf("argc : %d\n",argc);
//    printf("argv : %s\n",*argv);
//    printf("envp : %s\n",*envp);
//    printf("apple : %s\n",*apple);
    
    [AshBacktrack threadBacktrack];
    
    ++vectorIndex;
    OriginalInitFunc func = (OriginalInitFunc)initFuncVector->at(vectorIndex);
    
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    
    func(argc,argv,envp,apple,vars);
    
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    sSumInitTime += 1000.0 * (end-start);
    NSString *cost = [NSString stringWithFormat:@"%p=%@",func,@(1000.0*(end - start))];
//    NSLog(@"cost : %@",cost);
}

static void hookModInitFunc(){
    Dl_info info;
    dladdr((const void *)hookModInitFunc, &info);
    
    #ifndef __LP64__
    //    const struct mach_header *mhp = _dyld_get_image_header(0); // 32位可以用这种方式获取
        const struct mach_header *header = info.dli_fbase;
    #else /* defined(__LP64__) */
    /// 64位必须这种获取方式
        const struct mach_header_64 *header = (struct mach_header_64*)info.dli_fbase;
    #endif /* defined(__LP64__) */
    unsigned long size = 0;
    uint_t *sectionData = (uint_t*)getsectiondata(header, "__DATA", "__mod_init_func", & size);
        for(int idx = 0; idx < size/sizeof(void*); ++idx){
            uint_t originalPtr = sectionData[idx];
            initFuncVector->push_back(originalPtr);
            sectionData[idx] = (uint_t)AshInitFunc;
        }

//    NSLog(@"zero mod init func : size = %@",@(size));
    
}

@interface NSObject (AshHookModInitFuncObject)

@end

@implementation NSObject (AshHookModInitFuncObject)

+ (void)load{
    initFuncVector = new std::vector<uint_t>();
    vectorIndex = -1;
    [AshBacktrack setBackCount:10];
    hookModInitFunc();
}

@end
