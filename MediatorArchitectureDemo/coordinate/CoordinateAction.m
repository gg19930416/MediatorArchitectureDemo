//
//  CoordinateAction.m
//  MediatorArchitectureDemo
//
//  Created by 郭刚 on 2019/6/3.
//  Copyright © 2019 郭刚. All rights reserved.
//

#import "CoordinateAction.h"

@interface CoordinateAction ()

@property (nonatomic,strong) NSString *chainCls;
@end

@implementation CoordinateAction

+ (CoordinateAction *)classMethod:(NSString *)classMethod {
    return [CoordinateAction classMethod:classMethod parameters:nil toState:nil];
}
+ (CoordinateAction *)classMethod:(NSString *)classMethod parameters:(NSMutableDictionary *)paramters {
    return [CoordinateAction classMethod:classMethod parameters:paramters toState:nil];
}
+ (CoordinateAction *)classMethod:(NSString *)classMethod parameters:(NSMutableDictionary *)paramters toState:(NSString *)toState {
    CoordinateAction *cat = [[CoordinateAction alloc] init];
    cat.classMethod = classMethod;
    cat.parameters = paramters;
    cat.toState = toState;
    return cat;
}

// Chain Helper
/** 类和方法 */
+ (CoordinateAction *(^)(NSString *))clsmtd {
    return ^CoordinateAction *(NSString *clsmtd) {
        CoordinateAction *act = [[CoordinateAction alloc] init];
        act.classMethod = clsmtd;
        return act;
    };
}

/** 类 */
+ (CoordinateAction *(^)(NSString *))cls {
    return ^CoordinateAction *(NSString *cls) {
        CoordinateAction *act = [[CoordinateAction alloc] init];
        act.chainCls = cls;
        return act;
    };
}


- (CoordinateAction *(^)(NSString *))mtd {
    return ^CoordinateAction *(NSString *mtd) {
        self.classMethod = [NSString stringWithFormat:@"%@ %@",self.chainCls, mtd];
        return self;
    };
}

/** 可选: 参数 */
- (CoordinateAction *(^)(NSMutableDictionary *))pa {
    return ^CoordinateAction *(NSMutableDictionary *pa) {
        self.parameters = pa;
        return self;
    };
}
/** 可选: 更改状态 */
- (CoordinateAction *(^)(NSString *))toSt {
    return ^CoordinateAction *(NSString *toSt) {
        self.toState = toSt;
        return self;
    };
}


/// 能在编译期检查类和方法的方法
/** 类 */
+ (CoordinateAction *(^)(Class))clas {
    return ^CoordinateAction *(Class clas) {
        CoordinateAction *act = [[CoordinateAction alloc] init];
        act.chainCls = NSStringFromClass(clas);
        return act;
    };
}
/** 方法 */
- (CoordinateAction *(^)(SEL))mted {
    return ^CoordinateAction *(SEL mted) {
        NSString *selStr = NSStringFromSelector(mted);
        NSString *cleearSelStr = [selStr substringToIndex:[selStr length] - 1];
        self.classMethod = [NSString stringWithFormat:@"%@ %@",self.chainCls,cleearSelStr];
        return self;
    };
}
@end
