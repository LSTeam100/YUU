//
//  UIImage+GenerateQRCode.m
//  loveOil
//
//  Created by swift on 8/10/16.
//  Copyright © 2016 macbookair. All rights reserved.
//

#import "UIImage+GenerateQRCode.h"

#import <AVFoundation/AVFoundation.h>


static NSString *const inputMessange = @"inputMessage";


@implementation UIImage (GenerateQRCode)


void ProvideReleaseData(void *info, const void *data, size_t size)
{
    free((void *)data);
}

/**
 *  默认宽高为300
 */

static CGFloat defaultWidth = 20;

static CGFloat defaultCornerValue = 15;

/**
 *  给上下文添加圆角蒙版
 */
void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image)
{
    float width, height;
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width = CGRectGetWidth(rect);
    height = CGRectGetHeight(rect);

    //裁剪路径

    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddArcToPoint(context, width, height, width / 2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height / 2, radius);
    CGContextAddArcToPoint(context, 0, 0, width / 2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height / 2, radius);
    CGContextClosePath(context);
    CGContextClip(context);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}


+ (UIImage *)imageOfRoundRectWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius
{
    if (!image || (NSNull *)image == [NSNull null]) {
        return nil;
    }

    const CGFloat width = size.width;
    const CGFloat height = size.height;

    radius = MAX(5.f, radius);
    radius = MIN(10.f, radius);

    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);

    //绘制圆角

    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];

    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);

    return img;
}


/********************************************************************************************************/

+ (CIImage *)GenarateCIImageByContent:(NSString *)content
{
    /**
     qrcode有个纠错等级的设置
     
     There are 4 error correction levels used for QR codes, with each one adding different amounts of “backup” data depending on how much damage the QR code is expected to suffer in its intended environment, and hence how much error correction may be required:
     
     Level L – up to 7% damage
     Level M – up to 15% damage
     Level Q – up to 25% damage
     Level H – up to 30% damage
     
     */

    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    NSData *stringData = [content dataUsingEncoding:NSUTF8StringEncoding];

    [qrFilter setValue:stringData forKey:inputMessange];

    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];

    CIImage *image = qrFilter.outputImage;

    return image;
}

+ (UIImage *)generateQRCodeViaContents:(NSString *)contens
{
    CIImage *filterOutputImage = [UIImage GenarateCIImageByContent:contens];

    CGSize size = CGSizeMake(defaultWidth, defaultWidth);

    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:filterOutputImage fromRect:filterOutputImage.extent];

    UIGraphicsBeginImageContext(size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetInterpolationQuality(context, kCGInterpolationNone);

    CGContextScaleCTM(context, 1, -1);

    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);

    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    CGImageRelease(cgImage);

    return qrImage;
}

+ (UIImage *)generateQRCodeViaContents:(NSString *)contens withQRCodeSize:(CGFloat)QRCodeSize
{
    if (!QRCodeSize) {
        QRCodeSize = defaultWidth;
    }

    CIImage *filterOutputImage = [UIImage GenarateCIImageByContent:contens];

    CGRect extent = CGRectIntegral(filterOutputImage.extent);
    CGFloat scale = MIN(QRCodeSize / CGRectGetWidth(extent), QRCodeSize / CGRectGetHeight(extent));

    // 1.创建bitmap;

    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:filterOutputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 2.保存bitmap到图片

    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);

    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)generateQRCodeViaContents:(NSString *)contens withQRCodeSize:(CGFloat)QRCodeSize forColorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue
{
    UIImage *image = [UIImage generateQRCodeViaContents:contens withQRCodeSize:QRCodeSize];


    const NSInteger imageWidth = image.size.width;
    const NSInteger imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);

    // 1.遍历像素

    NSInteger pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 2.输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProvideReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);

    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 3.清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    return resultUIImage;
}

+ (UIImage *)generateQRCodeViaContents:(NSString *)contens withQRCodeSize:(CGFloat)QRCodeSize withCenterImg:(UIImage *)centerIMG forColorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue
{
    UIImage *resultUIImage = [self generateQRCodeViaContents:contens withQRCodeSize:QRCodeSize forColorRed:red colorGreen:green colorBlue:blue];

    // 添加中心图片---生成圆角按钮

    centerIMG = [UIImage imageOfRoundRectWithImage:centerIMG size:centerIMG.size radius:defaultCornerValue];

    CGFloat logoW = resultUIImage.size.width / 5.0;
    CGRect logoFrame = CGRectMake(logoW * 2, logoW * 2, logoW, logoW);

    UIGraphicsBeginImageContext(resultUIImage.size);
    [resultUIImage drawInRect:CGRectMake(0, 0, resultUIImage.size.width, resultUIImage.size.height)];
    [centerIMG drawInRect:logoFrame];
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();


    return finalImg;
}

+ (UIImage *)generateQRCodeViaContents:(NSString *)contens withQRCodeSize:(CGFloat)QRCodeSize withCenterImg:(UIImage *)centerIMG
{
    UIImage *resultUIImage = [self generateQRCodeViaContents:contens withQRCodeSize:QRCodeSize];

    // 添加中心图片---生成圆角按钮

    centerIMG = [UIImage imageOfRoundRectWithImage:centerIMG size:centerIMG.size radius:defaultCornerValue];

    CGFloat logoW = resultUIImage.size.width / 5.0;
    CGRect logoFrame = CGRectMake(logoW * 2, logoW * 2, logoW, logoW);

    UIGraphicsBeginImageContext(resultUIImage.size);
    [resultUIImage drawInRect:CGRectMake(0, 0, resultUIImage.size.width, resultUIImage.size.height)];
    [centerIMG drawInRect:logoFrame];
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();


    return finalImg;
}


/**
 
 生成二维码(中间有小图片)
 
 QRStering：所需字符串
 
 centerImage：二维码中间的image对象
 
 */

+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage
{
    // 创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    // 恢复滤镜的默认属性
    [filter setDefaults];

    // 将字符串转换成 NSdata
    NSData *dataString = [QRString dataUsingEncoding:NSUTF8StringEncoding];

    // 设置过滤器的输入值, KVC赋值
    [filter setValue:dataString forKey:@"inputMessage"];

    // 获得滤镜输出的图像
    CIImage *outImage = [filter outputImage];

    // 图片小于(27,27),我们需要放大
    outImage = [outImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];

    // 将CIImage类型转成UIImage类型
    UIImage *startImage = [UIImage imageWithCIImage:outImage];

    // 开启绘图, 获取图形上下文
    UIGraphicsBeginImageContext(startImage.size);


    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];

    // 再把小图片画上去
    CGFloat icon_imageW = 200;
    CGFloat icon_imageH = icon_imageW;
    CGFloat icon_imageX = (startImage.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (startImage.size.height - icon_imageH) * 0.5;
    [centerImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];

    // 获取当前画得的这张图片
    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();

    // 关闭图形上下文

    UIGraphicsEndImageContext();

    //返回二维码图像

    return qrImage;
}


@end
