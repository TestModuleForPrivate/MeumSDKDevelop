//
//  TYBlueToothManager.m
//  BlueToothDemo
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "TYBlueToothManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "NSMutableArray+HexData.h"

@interface TYBlueToothManager()<CBPeripheralDelegate,CBCentralManagerDelegate>
@property(nonatomic,strong) CBCentralManager *central;
@property(nonatomic,strong) CBPeripheral *peripheral;
@property(nonatomic,strong) CBCharacteristic *characteristic;
@property(nonatomic,strong) NSData *data;
@end

@implementation TYBlueToothManager

#pragma mark - init
+ (instancetype)manager{
    static TYBlueToothManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self startScan];
    }
    return self;
}

#pragma mark - operation

- (void)startScan{
    [self central];
}

- (void)stopScan{
    [self.central stopScan];
}

#pragma mark - CBCentralManagerDelegate
/*
 * 搜索Peripheral
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"PeripheralName:%@",peripheral.name);
    if (!peripheral || [peripheral.name isEqualToString:@""]) {
        NSLog(@"无此设备");
        return;
    }
    
    //验证设备信息是否对等,连接设备
    if ((!self.peripheral || (self.peripheral.state == CBPeripheralStateDisconnected))&&([peripheral.name isEqualToString:_peripheralName])) {
        self.peripheral = [peripheral copy];
        NSLog(@"connect peripheral:  %@",peripheral);
        [self.central connectPeripheral:peripheral options:nil];
    }
}

/*
 * 蓝牙的状态
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBManagerStateUnknown:
        {
            NSLog(@"无法获取设备的蓝牙状态");
            
        }
            break;
        case CBManagerStateResetting:
        {
            NSLog(@"蓝牙重置");
            
        }
            break;
        case CBManagerStateUnsupported:
        {
            NSLog(@"该设备不支持蓝牙");
        }
            break;
        case CBManagerStateUnauthorized:
        {
            NSLog(@"未授权蓝牙权限");
        }
            break;
        case CBManagerStatePoweredOff:
        {
            NSLog(@"蓝牙已关闭");
        }
            break;
        case CBManagerStatePoweredOn:
        {
            NSLog(@"蓝牙已打开");
            //开始扫描Peripheral,Peripheral负责搜索更多的service
            [_central scanForPeripheralsWithServices:nil options:nil];
        }
            break;
            
        default:
        {
            NSLog(@"未知的蓝牙错误");
        }
            break;
    }
}

/*
 * peripheral 连接成功
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    if (!peripheral) {
        return;
    }
    //连接成功停止扫描
    [self stopScan];
    
    //设置peripheral delegate
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
}

/*
 * 连接失败
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接失败");
}

#pragma mark - CBPeripheralDelegate

/*
 * 扫描service
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSArray *services = peripheral.services;
    if (services.count == 0) {
        NSLog(@"没有可连接的设备");
        return;
    }
    
    for (CBService *service in services) {
        if ([service.UUID.UUIDString isEqualToString:_peripheralUUID]) {
            //找到了,就停止循环
            [peripheral discoverCharacteristics:nil forService:service];
            return;
        }
    }
}
/*
 * 找到service的characteristic
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error) {
        NSLog(@"error:%@",error.localizedDescription);
        return;
    }
    
    for (CBCharacteristic *chac in service.characteristics) {
        NSLog(@"特征UUID FOUND(in 服务UUID:%@): %@ (data:%@)",service.UUID.description,chac.UUID,chac.UUID.data);
        //发送读数据的通知
        if ([chac.UUID.UUIDString isEqualToString:_peripheralReadUUID]) {
            self.characteristic = chac;
            [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        }
        //发送写数据的通知
        if ([chac.UUID.UUIDString isEqualToString:_peripheralWriteUUID]) {
            self.characteristic = chac;
            [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        }
    }
}
/*
 * 读取数据
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    if (error)
    {
        NSLog(@"error : %@", error.localizedDescription);
        return;
    }
    NSData *data = characteristic.value;
    NSArray *dataArr = [NSMutableArray convertDataToHexStr:data];
    self.data = data;
    NSLog(@"读取的数据是 : %@", dataArr);
}

//向peripheral中写入数据后的回调函数
- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //该方法可以监听到写入外设数据后的状态
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
        return;
        
    }
    
    NSLog(@"write value success : %@", characteristic);
}

#pragma mark - private

- (void)getBLData:(BLDataBlock)dataBlock{
//    if (!self.data) {
//        NSLog(@"无数据");
//        return;
//    }
    dataBlock ? dataBlock(@{@"Step" : @"10000",@"HearbeatPerMinute" : @"12212"}) : nil;
}

- (void)cancelPeripheralConnection{
    
    //self.isInitiativeDisconnect = YES;
    if (self.peripheral) {//已经连接外设，则断开
        [self.central cancelPeripheralConnection:self.peripheral];
    }else{//未连接，则停止搜索外设
        [self.central stopScan];
    }
    
}

/**
 发送命令
 */
- (void) sendData:(NSData *)data{
    
    /**
     通过CBPeripheral 类 将数据写入蓝牙外设中,蓝牙外设所识别的数据为十六进制数据,在ios系统代理方法中将十六进制数据改为 NSData 类型 ,但是该数据形式必须为十六进制数 0*ff 0*ff格式 在iToll中有将 字符串转化为 十六进制 再转化为 NSData的方法
     
     */
    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
    
}


#pragma mark - getter && setter

- (void)setPeripheralName:(NSString *)peripheralName{
    _peripheralName = peripheralName;
}

- (void)setPeripheralUUID:(NSString *)peripheralUUID{
    _peripheralUUID = peripheralUUID;
}

- (void)setPeripheralReadUUID:(NSString *)peripheralReadUUID{
    _peripheralReadUUID = peripheralReadUUID;
}

- (void)setPeripheralWriteUUID:(NSString *)peripheralWriteUUID{
    _peripheralWriteUUID = peripheralWriteUUID;
}

- (CBCentralManager *)central{
    if (!_central) {
        _central = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    return _central;
}

@end
