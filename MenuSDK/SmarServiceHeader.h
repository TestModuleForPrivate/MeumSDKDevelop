//
//  SmarServiceHeader.h
//  MenuSDK
//
//  Created by huangwei on 2017/8/31.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#ifndef SmarServiceHeader_h
#define SmarServiceHeader_h
typedef NS_ENUM(NSInteger,SmartPeripheralType){
    SmartPeripheralTypeBracelet,
    SmartPeripheralTypeOther
};

@class SmartService;
@protocol SmartServiceDelegate <NSObject>

- (void)smartService:(SmartService *)service readData:(id)data;

@end

#endif /* SmarServiceHeader_h */
