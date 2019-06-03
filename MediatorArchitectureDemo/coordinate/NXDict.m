//
//  NXDict.m
//  MediatorArchitectureDemo
//
//  Created by 郭刚 on 2019/6/3.
//  Copyright © 2019 郭刚. All rights reserved.
//

#import "NXDict.h"

@interface NXDict ()

@property (nonatomic,strong) NSMutableDictionary *chainDic;
@property (nonatomic,strong) NSString *chainCurrentKey;

@end

@implementation NXDict

+ (NXDict *)create {
    return [[NXDict alloc] init];
}

// 参数
- (NXDict *(^)(NSString *))key{
    return ^NXDict *(NSString *pKey) {
        self.chainCurrentKey = pKey;
        return self;
    };
}

- (NXDict *(^)(id))val{
    return ^NXDict *(NSString *pVal) {
        self.chainDic[self.chainCurrentKey] = pVal;
        return self;
    };
}

- (NSMutableDictionary *)done {
    NSMutableDictionary *re = [NSMutableDictionary dictionaryWithDictionary:self.chainDic];
    self.chainDic = [NSMutableDictionary new];
    return re;
}

// getter
- (NSMutableDictionary *)chainDic {
    if (!_chainDic) {
        _chainDic = [NSMutableDictionary new];
    }
    return _chainDic;
}

@end
