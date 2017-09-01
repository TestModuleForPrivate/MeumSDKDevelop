//
//  SmartPeripheralFactory.h
//  MenuSDK
//
//  Created by huangwei on 2017/8/30.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartPeripheralFactory : NSObject
+ (id)smartPeripheralInstanceWithSmartPeripheralName:(NSString *)name;
@end
