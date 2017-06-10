//
//  Teacher.m
//  MsgSendDemo
//
//  Created by Kelvin on 2017/6/10.
//  Copyright © 2017年 Kelvin. All rights reserved.
//

#import "Teacher.h"
#import "Student.h"
#import <objc/runtime.h>

@implementation Teacher

// 动态方法解析
//void playPiano()
//{
//    NSLog(@"teacher: Play Piano");
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSString *method = NSStringFromSelector(sel);
//    if ([@"playPiano" isEqualToString:method]) {
//        /**
//         添加方法
//
//         @param self 调用该方法的对象
//         @param sel 选择子
//         @param IMP 添加的方法，是c语言实现的
//         @param 新添加的方法的类型，包含函数的返回值以及参数内容类型，eg：void xxx(NSString *name, int size)，类型为：v@i
//         */
//        class_addMethod(self, sel, (IMP)playPiano, "v");
//        return YES;
//    }
//    return NO;
//}

// 备援接受者
//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    NSString *seletorString = NSStringFromSelector(aSelector);
//    if ([@"playPiano" isEqualToString:seletorString]) {
//        Student *s = [[Student alloc] init];
//        return s;
//    }
//    // 继续转发
//    return [super forwardingTargetForSelector:aSelector];
//}

// 完整的消息转发
- (void)travel:(NSString*)city
{
    NSLog(@"Teacher travel：%@", city);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *method = NSStringFromSelector(aSelector);
    if ([@"playPiano" isEqualToString:method]) {
        
        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return signature;
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = @selector(travel:);
    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    anInvocation = [NSInvocation invocationWithMethodSignature:signature];
    [anInvocation setTarget:self];
    [anInvocation setSelector:@selector(travel:)];
    NSString *city = @"北京";
    [anInvocation setArgument:&city atIndex:2];
    
    if ([self respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self];
        return;
    } else {
        Student *s = [[Student alloc] init];
        if ([s respondsToSelector:sel]) {
            [anInvocation invokeWithTarget:s];
            return;
        }
    }
    
    // 从继承树中查找
    [super forwardInvocation:anInvocation];
}

@end
