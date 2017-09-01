//
//  NSMutableArray+HexData.m
//  BlueToothDemo
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "NSMutableArray+HexData.h"

@implementation NSMutableArray (HexData)
/**
 十六进制数据转化为数组
 
 @param data 十六进制数据
 @return 转化后的数组
 */
+ (NSMutableArray *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return nil;
    }
    
    /**
     将切割好的十六进制数塞入一个可变数组
     */
    NSMutableArray *dataArr = [NSMutableArray new];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        
        for (NSInteger i = 0; i < byteRange.length; i++) {
            
            /**
             将byte数组切割成一个个字符串
             */
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            // NSLog(@"%@",hexStr);
            /**
             因十六进制数据为 0X XXXX 以两字节为一位数,所以需要在切割出来的数据进行补零操作
             */
            
            if ([hexStr length] == 2) {
                // [string appendString:hexStr];
                [dataArr addObject:hexStr];
            } else {
                //[string appendFormat:@"0%@", hexStr];
                
                [dataArr addObject:[NSString stringWithFormat:@"0%@",hexStr]];
            }
        }
    }];
    // NSLog(@"-------->%@",dataArr);
    
    
    return dataArr;
}
@end
