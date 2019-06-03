//
//  Coordinate.h
//  MediatorArchitectureDemo
//
//  Created by 郭刚 on 2019/6/3.
//  Copyright © 2019 郭刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateAction.h"
#import "NXDict.h"

NS_ASSUME_NONNULL_BEGIN

@interface Coordinate : NSObject

/** 解指令执行 **/
- (void)eval:(NSString *)script;//重新运行脚本
/* --------- Reducer (减速器) --------- */
// Reducer 下面几种是不同的额调用写法,最终的执行是一致的.
- (id)dispatch:(CoordinateAction *)action; // 可设置更改当前状态
- (id)classMethod:(NSString *)classMethod;
- (id)classMethod:(NSString *)classMethod parameters:(NSDictionary *)parameters;

// helper
- (id (^)(CoordinateAction *))dispatch;

/* ------------ Middleware (中介者) --------------- */
// Middleware 当设置的方法执行时先执行指定的方法,可用于观察某方法的执行,然后通知其他 com 执行观察方法进行响应
- (void)middleware:(NSString *)whenClassMethod thenAddDispath:(CoordinateAction *)action;
// MMiddleware 链式写法支持
- (Coordinate *(^)(NSString *))middleware;
- (Coordinate *(^)(CoordinateAction *))addMiddlewareAction;

/* --------------- State ------------------ */
// State manager 状态管理
- (NSString *)currentState;
- (void)updateCurrentState:(NSString *)state;
// State 链式写法支持
- (Coordinate *(^)(NSString *))updateCurrentState;

/* ------------- Observer --------------- */
// Observer
- (void)observeWithIdentifier:(NSString *)identifier objserver:(CoordinateAction *)act;
- (void)notifyObservers:(NSString *)identifier;
// Observer 链式写法支持
- (Coordinate *(^)(NSString *))observerWithIdentifier;
- (Coordinate *(^)(CoordinateAction *))addObserver;

/* ----------Factory (工厂方法) --------------- */
- (void)factoryClass:(NSString *)fClass useFactory:(NSString *)factory;
// Factory 链式写法
- (Coordinate *(^)(NSString *))factoryClass;
- (Coordinate *(^)(NSString *))factory;

@end

NS_ASSUME_NONNULL_END

