//
//  UIImage+GenerateQRCode.h
//  loveOil
//
//  Created by swift on 8/10/16.
//  Copyright © 2016 macbookair. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  生成二维码
 */


@interface UIImage (GenerateQRCode)

/**
 *  根据具体的内容生成二维码 //例如网址
 *
 *  @param contens 内容
 *
 *  @return 二维码图片
 */

+ (nullable UIImage *)generateQRCodeViaContents:(nonnull NSString *)contens;

/**
 *  根据内容 和 尺寸生成相应的二维码
 *
 *  @param contens    内容
 *  @param QRCodeSize 正方形/只需要指定一个值即可
 *
 *  @return 二维码图片
 */

+ (nullable UIImage *)generateQRCodeViaContents:(nonnull NSString *)contens withQRCodeSize:(CGFloat)QRCodeSize;


/**
 *  根据内容 尺寸 和 颜色生成二维码
 *
 *  @param contens    内容
 *  @param QRCodeSize 正方形/只需要指定一个值即可
 *  @param red red
 *  @param green green
 *  @param blue blue
 *  颜色不可以太接近白色
 *  @return   二维码图片
 */

+ (nullable UIImage *)generateQRCodeViaContents:(nonnull NSString *)contens withQRCodeSize:(CGFloat)QRCodeSize forColorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue;


/**
 *  根据内容 尺寸 和 颜色 以及中心图片生成
 *  @param contens    内容
 *  @param QRCodeSize 正方形/只需要指定
 *  @param centerIMG  中心图片
 *  @param red        red
 *  @param green      green
 *  @param blue       blue
 *
 *  @return 二维码图片
 */

+ (nullable UIImage *)generateQRCodeViaContents:(nonnull NSString *)contens withQRCodeSize:(CGFloat)QRCodeSize withCenterImg:(nonnull UIImage *)centerIMG forColorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue;

+ (nullable UIImage *)generateQRCodeViaContents:(nullable NSString *)contens withQRCodeSize:(CGFloat)QRCodeSize withCenterImg:(nullable UIImage *)centerIMG;

/**
 
 生成二维码(中间有小图片)
 
 QRStering：字符串
 
 centerImage：二维码中间的image对象
 
 */

+ (nullable UIImage *)createImgQRCodeWithString:(nonnull NSString *)QRString centerImage:(nonnull UIImage *)centerImage;

@end
