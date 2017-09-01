//
//  UIImage+BundleImage.m
//  MenuSDK
//
//  Created by huangwei on 2017/8/29.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "UIImage+BundleImage.h"

@implementation UIImage (BundleImage)
+ (UIImage *)bundleImageWithName:(NSString *)imageName{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"MenuSDKSources.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *path = [bundle pathForResource:imageName ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}
@end
