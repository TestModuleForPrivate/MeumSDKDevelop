//
//  SmartBraceletFactory.m
//  MeumSDK
//
//  Created by huangwei on 2017/8/31.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "SmartBraceletFactory.h"

@implementation SmartBraceletFactory
+ (id)smartPeripheralInstanceWithSmartPeripheralName:(NSString *)name{
    id instance = [[NSClassFromString(name) alloc] init];
    if (!instance || ![instance conformsToProtocol:@protocol(SmartBraceletProtocol)]) {
        return nil;
    }
    return instance;
}
@end
