//
//  NSArray+Help.m
//  APPHelp
//
//  Created by boli on 2018/8/7.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "NSArray+Help.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSArray (Help)

//When you create an array, you don't get an instance of NSArray. You usually get an NSCFArray, although there are other private classes, like __NSArrayM and so on.

//That's because NSArray is a class cluster.
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = object_getClass((id)self);
//
//        SEL originalSelector = @selector(objectAtIndex:);
//        SEL swizzledSelector = @selector(safeObjectAtIndex:);
//
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//        BOOL didAddMethod =
//        class_addMethod(class,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod));
//
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}





@end
