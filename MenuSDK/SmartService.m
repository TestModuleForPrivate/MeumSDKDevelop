//
//  SmartService.m
//  MenuSDK
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "SmartService.h"
#import "SmartBraceletFactory.h"
#import "SmartBracelet.h"
#define WeakSelf __weak typeof(self) weakSelf = self;

NSString *const KSmartBracelet_MI = @"SmartBracelet_MI";
NSString *const KSmartBracelet_LAKALA = @"SmartBracelet_LAKALA";

@interface SmartService()

@property(nonatomic,strong) NSDictionary *smartPeripheralTypeDict;

@end

@implementation SmartService
+ (instancetype)smartService{
    static SmartService *smartService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        smartService = [[self alloc] init];
    });
    return smartService;
}
- (void)connectSmartPeripheral{
    
    [self noPeripheralName];
    [self noPeripheralType];
    
    switch (self.type) {
        
        case SmartPeripheralTypeBracelet:
        {
            WeakSelf;
            
            SmartBracelet<SmartBraceletProtocol> *bracelet = [SmartBraceletFactory smartPeripheralInstanceWithSmartPeripheralName:self.smartPeripheralTypeDict[self.peripheralName]];
            
            if (self.isSupportBlueTooth) {
                [bracelet connectPeripheralWithBlueTooth];
            }else{
                [bracelet connectPeripheralWithOpenPlatform];
            }
            [bracelet readSmartPeripheralWithDataReadSuccessBlock:^(id data) {
                [weakSelf.delegate respondsToSelector:@selector(smartService:readData:)] ? [weakSelf.delegate smartService:self readData:data] : nil;
            }];
        }
            break;
        case SmartPeripheralTypeOther:
        {
            
        }
            break;

    }
}

#pragma mark - private

- (void)noPeripheralName{
    if (!_peripheralName) {
        NSException *exception = [NSException exceptionWithName:@"noPeripheralName" reason:@"eripheralName must be nonull" userInfo:nil];
        @throw exception;
    }
}

- (void)noPeripheralType{
    if (_type > 1) {
        NSException *exception = [NSException exceptionWithName:@"noPeripheralType" reason:@"PeripheralType must be nonull" userInfo:nil];
        @throw exception;
    }
}

#pragma mark - getter && setter

- (void)setPeripheralName:(NSString *)peripheralName{
    _peripheralName = peripheralName;
}

- (void)setType:(SmartPeripheralType)type{
    _type = type;
}
/*
 * 存储所支持的设备
 */
- (NSDictionary *)smartPeripheralTypeDict{
    if (!_smartPeripheralTypeDict) {
        _smartPeripheralTypeDict = @{
                                     @"SmartBraceletMI" : KSmartBracelet_MI,
                                     @"SmartBraceletLAKALA" : KSmartBracelet_LAKALA
                                     };
    }
    return _smartPeripheralTypeDict;
}

@end
