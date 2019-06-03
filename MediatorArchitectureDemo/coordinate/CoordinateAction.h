//
//  CoordinateAction.h
//  MediatorArchitectureDemo
//
//  Created by 郭刚 on 2019/6/3.
//  Copyright © 2019 郭刚. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CLS(cls) NSStringFromClass((cls))
#define ACT(s) NSStringFromSelector((s))

@interface CoordinateAction : NSObject

@property (nonatomic,strong) NSString *classMethod;
@property (nonatomic,strong) NSMutableDictionary *parameters;

// state
@property (nonatomic,strong) NSString *toState;

+ (CoordinateAction *)classMethod:(NSString *)classMethod;
+ (CoordinateAction *)classMethod:(NSString *)classMethod parameters:(NSMutableDictionary *)paramters;
+ (CoordinateAction *)classMethod:(NSString *)classMethod parameters:(NSMutableDictionary *)paramters toState:(NSString *)toState;

// Chain Helper
/** 类和方法 */
+ (CoordinateAction *(^)(NSString *))clsmtd;
/** 类 */
+ (CoordinateAction *(^)(NSString *))cls;
/** 方法 */
- (CoordinateAction *(^)(NSString *))mtd;
/** 可选: 参数 */
- (CoordinateAction *(^)(NSMutableDictionary *))pa;
/** 可选: 更改状态 */
- (CoordinateAction *(^)(NSString *))toSt;

/// 能在编译期检查类和方法的方法
/** 类 */
+ (CoordinateAction *(^)(Class))clas;
/** 方法 */
- (CoordinateAction *(^)(SEL))mted;

@end

