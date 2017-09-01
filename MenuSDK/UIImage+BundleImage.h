//
//  UIImage+BundleImage.h
//  MenuSDK
//
//  Created by huangwei on 2017/8/29.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BundleImage)

/**
 找到bundle中的图片

 @param imageName 图片名,如果是除png之外的其他格式,请加上后缀
 @return bundle中的图片
 */
+ (UIImage *)bundleImageWithName:(NSString *)imageName;

@end
