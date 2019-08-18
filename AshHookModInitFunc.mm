//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <unistd.h>
#import <mach-o/getsect.h>
#import <mach-o/loader.h>
#import <mach-o/dyld.h>
#import <dlfcn.h>
#import <vector>

static NSTimeInterval sSumInitTime;

using namespace std;

#ifndef __LP64__
typedef uint32_t uint_t;
typedef struct mach_header mach_header_t;
#else /* defined(__LP64__) */
typedef uint64_t uint_t;
typedef struct mach_header_64 mach_header_t;
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
    printf("mod_init_func\n");
    printf("argc : %d\n",argc);
    printf("argv : %s\n",*argv);
    printf("envp : %s\n",*envp);
    printf("apple : %s\n",*apple);
    
    ++vectorIndex;
    OriginalInitFunc func = (OriginalInitFunc)initFuncVector->at(vectorIndex);
    
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    
    func(argc,argv,envp,apple,vars);
    
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    sSumInitTime += 1000.0 * (end-start);
    NSString *cost = [NSString stringWithFormat:@"%p=%@",func,@(1000.0*(end - start))];
    NSLog(@"cost : %@",cost);
}

static void hookModInitFunc(){
    Dl_info info;
    dladdr((const void *)hookModInitFunc, &info);
    
    const mach_header_t *header = (mach_header_t*)info.dli_fbase;
    unsigned long size = 0;
    uint_t *sectionData = (uint_t*)getsectiondata(header, "__DATA", "__mod_init_func", & size);
    for(int idx = 0; idx < size/sizeof(void*); ++idx){
        uint_t originalPtr = sectionData[idx];
        initFuncVector->push_back(originalPtr);
        sectionData[idx] = (uint_t)AshInitFunc;
    }
    
}

@interface NSObject (AshHookModInitFunc)

@end

@implementation NSObject (AshHookModInitFunc)

+ (void)load{
    initFuncVector = new std::vector<uint_t>();
    vectorIndex = -1;
    hookModInitFunc();
}

@end
