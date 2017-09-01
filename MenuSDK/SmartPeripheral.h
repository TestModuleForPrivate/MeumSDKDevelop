//
//  SmartPeripheral.h
//  MenuSDK
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//  这是一个智能设备的基类,手环或者其他智能设备都继承此类

#import <Foundation/Foundation.h>
#import "DataFilterProtocol.h"
#import "TYBlueToothManager.h"
typedef void (^readDataBlock)(id);

@interface SmartPeripheral : NSObject
//获取的设备数据
@property(nonatomic,strong) readDataBlock dataBlock;

- (void)connectPeripheralWithBlueTooth;

- (void)connectPeripheralWithOpenPlatform;

- (id)filterDataWithFilter:(id<DataFilterProtocol>)filter withSourceData:(id)data;

@end
