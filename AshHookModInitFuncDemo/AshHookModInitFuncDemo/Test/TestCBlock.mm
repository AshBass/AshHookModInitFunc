//
//  AshHookModInitFunc.m
//  AshHookModInitFuncDemo
//
//  Created by Harry Houdini on 2019/4/6.
//  Copyright © 2019年 Harry Houdini. All rights reserved.
//

#import "TestCBlock.h"

typedef struct {
    NSString *const blank;
    NSString *const CDPServer;
    NSString *const countdown;
    NSString *const infoBox;
    NSString *const shop;
    NSString *const more;
    NSString *const CDPSdk;
    NSString *const notice;
    NSString *const recommend;
}O2OPGoodsDetailBlockId;

const O2OPGoodsDetailBlockId kBlockId = {
    .blank = @"detail_blank",
    .CDPServer = @"goods_detail_cdp",
    .countdown = @"goods_detail_countdown",
    .infoBox = @"goods_detail_infobox",
    .shop = @"goods_detail_shop",
    .more = @"goods_detail_more",
    .CDPSdk = @"detail_cdp_sdk",
    .notice = @"goods_detail_notice",
    .recommend = @"goods_detail_recommend",
};
