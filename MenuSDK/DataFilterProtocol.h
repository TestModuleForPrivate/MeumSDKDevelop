//
//  DataFilterProtocol.h
//  MenuSDK
//
//  Created by huangwei on 2017/8/31.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataFilterProtocol <NSObject>
/**
 * 过滤方法,传入一个请求实例和请求的数据,返回过滤后的数据
 */
- (id)filterdDataFromSourceData:(id)data;
@end
