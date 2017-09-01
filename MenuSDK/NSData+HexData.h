//
//  NSData+HexData.h
//  BlueToothDemo
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HexData)
+ (NSData *)stringToByte:(NSString*)string;
@end
