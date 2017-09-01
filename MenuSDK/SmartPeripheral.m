//
//  SmartPeripheral.m
//  MenuSDK
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "SmartPeripheral.h"

@implementation SmartPeripheral
- (void)connectPeripheralWithBlueTooth{};
- (void)connectPeripheralWithOpenPlatform{};
- (id)filterDataWithFilter:(id<DataFilterProtocol>)filter withSourceData:(id)data{
    return [filter filterdDataFromSourceData:data];
};
@end
