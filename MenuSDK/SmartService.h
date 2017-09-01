//
//  SmartService.h
//  MenuSDK
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmarServiceHeader.h"

@interface SmartService : NSObject

@property(nonatomic,weak) id<SmartServiceDelegate> delegate;
//指定设备名字
@property(nonatomic,strong) NSString *peripheralName;
//设备类型
@property(nonatomic,assign) SmartPeripheralType type;
//是否支持蓝牙
@property(nonatomic,assign) BOOL isSupportBlueTooth;
//是否支持开发平台
@property(nonatomic,assign) BOOL isSupportOpenPlatform;
//设备识别唯一的UUID
@property(nonatomic,strong) NSString *peripheralUUID;

+ (instancetype)smartService;

- (void)connectSmartPeripheral;
@end
