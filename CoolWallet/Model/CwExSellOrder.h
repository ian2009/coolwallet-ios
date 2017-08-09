//
//  CwExSellOrder.h
//  CoolWallet
//
//  Created by wen on 2016/1/25.
//  Copyright (c) 2016年 MAC-BRYAN. All rights reserved.
//

#import "CwExOrderBase.h"

@class CwExTx;

@interface CwExSellOrder : CwExOrderBase

@property (strong, nonatomic) NSString *blockOTP;
//hex string: trxId(4B) + accId(4B) + amount(8B) + mac1(32B) + nonce(16B)
@property (strong, nonatomic) NSString *blockData;
@property (strong, nonatomic) NSNumber *sumbitted;

@property (strong, nonatomic) CwExTx *exTrx;

@end
