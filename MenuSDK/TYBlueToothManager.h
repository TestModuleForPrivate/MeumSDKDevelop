//
//  TYBlueToothManager.h
//  BlueToothDemo
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^BLDataBlock)(id data);
@interface TYBlueToothManager : NSObject

@property(nonatomic,strong) NSString *peripheralName;//设备名
@property(nonatomic,strong) NSString *peripheralUUID;//设备唯一标识
@property(nonatomic,strong) NSString *peripheralWriteUUID;//设备写标识
@property(nonatomic,strong) NSString *peripheralReadUUID;//设备读标识
@property(nonatomic,strong) BLDataBlock dataBlock;

+ (instancetype)manager;
/*
 * 开始扫描
 */
- (void)startScan;
/*
 * 停止扫描
 */
- (void)stopScan;
/*
 * 获取蓝牙的数据
 */
- (void)getBLData:(BLDataBlock)dataBlock;

@end
