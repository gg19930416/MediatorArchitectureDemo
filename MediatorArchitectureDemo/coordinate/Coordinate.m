//
//  Coordinate.m
//  MediatorArchitectureDemo
//
//  Created by 郭刚 on 2019/6/3.
//  Copyright © 2019 郭刚. All rights reserved.
//

#import "Coordinate.h"

@interface Coordinate ()
@property (nonatomic,strong) NSMutableDictionary *classes;

/* state (状态) */
@property (nonatomic,copy) NSString *p_currentState;

/* Middleware (中间件) */
@property (nonatomic,strong) NSMutableDictionary *middlewares; //中间件
@property (nonatomic,strong) NSString *chainMiddlewareKey;

/* observer (c观察者) */
@property (nonatomic,strong) NSMutableDictionary *observersIdenterifier; //储存 identifier 观察者
@property (nonatomic,strong) NSString *chainIdentifier;

/* Factories (工厂方法) */
@property (nonatomic,strong) NSMutableDictionary *factories;
@property (nonatomic,strong) NSString *chainFactoryClass;
@end

@implementation Coordinate

- (void)eval:(NSString *)script{
    
}

//-------- statee ---------
- (void)updateCurrentState:(NSString *)state {
    if (state.length  < 1) {
        return;
    }
    self.p_currentState = state;
}

- (NSString *)currentState {
    return self.p_currentState;
}

- (Coordinate *(^)(NSString *))updateCurrentState {
    return ^Coordinate *(NSString *state) {
        if (state.length > 0) {
            self.p_currentState = state;
        }
        return self;
    };
}

// ------------ Middleware --------------
- (void)middleware:(NSString *)whenClassMethod thenAddDispath:(CoordinateAction *)action {
    if (whenClassMethod.length < 1 || !action) {
        return;
    }
    NSMutableArray *mArr = [self.middlewares objectForKey:whenClassMethod];
    if (!mArr) {
        mArr = [NSMutableArray new];
    }
    [mArr addObject:action];
    self.middlewares[whenClassMethod] = mArr;
}

- (Coordinate *(^)(NSString *))middleware {
    return ^Coordinate *(NSString *mid) {
        if (mid.length < 1) {
            return self;
        }
        self.chainMiddlewareKey = mid;
        return self;
    };
}

- (Coordinate *(^)(CoordinateAction *))addMiddlewareAction {
    return ^Coordinate *(CoordinateAction *act) {
        if (!act) {
            return self;
        }
        NSMutableArray *mArr = [self.middlewares objectForKey:self.chainMiddlewareKey];
        if (!mArr) {
            mArr = [NSMutableArray new];
        }
        [mArr addObject:act];
        self.middlewares[self.chainMiddlewareKey] = mArr;
        return self;
    };
}

// --------- Observer ---------
- (void)observeWithIdentifier:(NSString *)identifier objserver:(CoordinateAction *)act {
    if (identifier.length < 1 || !act) {
        return;
    }
    
    NSMutableArray *mArr = [self.observersIdenterifier objectForKey:identifier];
    if (!mArr) {
        mArr = [NSMutableArray new];
    }
    [mArr addObject:act];
    self.observersIdenterifier[identifier] = mArr;
}

- (void)notifyObservers:(NSString *)identifier {
    NSMutableArray *mArr = [self.observersIdenterifier objectForKey:identifier];
    if ( mArr.count > 0) {
        for (CoordinateAction *act in mArr) {
            self.dispatch(act);
        }
    }
}

- (Coordinate *(^)(NSString *))observerWithIdentifier {
    return ^Coordinate *(NSString *identifier) {
        if (identifier.length > 0) {
            self.chainIdentifier = identifier;
        }
        return self;
    };
}

- (Coordinate * (^)(CoordinateAction *))addObserver {
    return ^Coordinate *(CoordinateAction *act) {
        NSMutableArray *mArr = [self.observersIdenterifier objectForKey:self.chainMiddlewareKey];
        if (!mArr) {
            mArr = [NSMutableArray new];
        }
        [mArr addObject:act];
        self.observersIdenterifier[self.chainIdentifier] = mArr;
        return self;
    };
}

// -----------Factory--------------
-(void)factoryClass:(NSString *)fClass useFactory:(NSString *)factory {
    if (fClass.length < 1 || factory.length < 1) {
        return;
    }
    self.factories[fClass] = factory;
}

- (Coordinate *(^)(NSString *))factoryClass {
    return ^Coordinate *(NSString *fClass) {
        self.chainFactoryClass = fClass;
        return self;
    };
}

- (Coordinate * (^)(NSString *))factory {
    return ^Coordinate *(NSString *factory) {
        self.factories[self.chainFactoryClass] = factory;
        return self;
    };
}

// ---------- Action ---------
// Chain dispath
- (id (^)(CoordinateAction *))dispatch {
    return ^Coordinate *(CoordinateAction *act) {
        return [self dispatch:act];
    };
}
@end
