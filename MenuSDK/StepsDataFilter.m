//
//  StepsDataFilter.m
//  MenuSDK
//
//  Created by huangwei on 2017/8/31.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "StepsDataFilter.h"

@implementation StepsDataFilter
- (id)filterdDataFromSourceData:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data[@"Step"];
    }
    return nil;
}
@end
