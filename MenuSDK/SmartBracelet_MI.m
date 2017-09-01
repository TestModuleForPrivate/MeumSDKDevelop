//
//  SmartBracelet_MI.m
//  MenuSDK
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "SmartBracelet_MI.h"
#import "StepsDataFilter.h"
@interface SmartBracelet_MI()
@property(nonatomic,strong) StepsDataFilter *stepsFilter;
@end

@implementation SmartBracelet_MI
- (void)connectPeripheralWithBlueTooth{
    [TYBlueToothManager manager].peripheralName = @"MI Band 2";
    [[TYBlueToothManager manager] startScan];
}

- (void)connectPeripheralWithOpenPlatform{
    
}

- (void)connect{
    
}

- (void)verify{
    
}

- (void)readSmartPeripheralWithDataReadSuccessBlock:(void (^)(id))readBlock{
    //过滤想要的数据,这里拿到步数
    [[TYBlueToothManager manager] getBLData:^(id data) {
        id data1 = [self filterDataWithFilter:self.stepsFilter withSourceData:data];
        readBlock ? readBlock(data1) : nil;
    }];
    
   // readBlock ? readBlock(data) : nil;
}

#pragma mark - getter

- (StepsDataFilter *)stepsFilter{
    if (!_stepsFilter) {
        _stepsFilter = [[StepsDataFilter alloc] init];
    }
    return _stepsFilter;
}

@end
