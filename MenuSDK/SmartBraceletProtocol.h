//
//  SmartBraceletProtocol.h
//  MenuSDK
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 智能手环必须遵守的协议
 */
@protocol SmartBraceletProtocol <NSObject>
- (void)connect;
- (void)verify;
- (void)readSmartPeripheralWithDataReadSuccessBlock:(void(^)(id data))readBlock;
@end
