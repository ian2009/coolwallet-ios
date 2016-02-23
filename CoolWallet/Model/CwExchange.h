//
//  CwExchange.h
//  CoolWallet
//
//  Created by 鄭斐文 on 2016/1/12.
//  Copyright © 2016年 MAC-BRYAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CwExAPI.h"

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class CwCard, CwAccount;

@interface CwExchange : NSObject

@property (readonly, nonatomic) CwCard *card;
@property (readonly, assign) ExSessionStatus sessionStatus;
@property (readonly, nonatomic) BOOL cardInfoSynced;

+(id)sharedInstance;

-(void) loginExSession;
-(void) syncCardInfo;
-(void) blockWithOrderID:(NSString *)hexOrderID withOTP:(NSString *)otp withComplete:(void(^)(void))completeCallback error:(void(^)(NSError *error))errorCallback;
-(void) prepareTransactionWithAmount:(NSNumber *)amountBTC withChangeAddress:(NSString *)changeAddress fromAccountId:(NSInteger)accountId;
-(void) completeTransactionWithOrderId:(NSString *)orderId TxId:(NSString *)txId;

-(RACSignal *)loginSignal;
-(RACSignal *)signalGetOpenOrderCount;
-(RACSignal *)signalCancelOrders:(NSString *)orderId;

-(AFHTTPRequestOperationManager *) defaultJsonManager;

@end
