//
//  NXDict.h
//  MediatorArchitectureDemo
//
//  Created by 郭刚 on 2019/6/3.
//  Copyright © 2019 郭刚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXDict : NSObject

+ (NXDict *)create;

- (NXDict *(^)(NSString *))key;
- (NXDict *(^)(id))val;
- (NSMutableDictionary *)done;

@end

NS_ASSUME_NONNULL_END
