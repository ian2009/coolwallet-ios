//
//  CwExTx.h
//  CoolWallet
//
//  Created by 鄭斐文 on 2016/1/30.
//  Copyright © 2016年 MAC-BRYAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CWTx, CwBtc;
@interface CwExTx : NSObject

@property (assign, nonatomic) NSInteger accountId;
@property (strong, nonatomic) NSData *loginHandle;
@property (strong, nonatomic) NSString *receiveAddress;
@property (strong, nonatomic) NSString *changeAddress;
@property (strong, nonatomic) CwBtc *amount;
@property (strong, nonatomic) CWTx *unsignedTx;

@end
