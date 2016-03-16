//
//  VTMerchantClient.m
//  MidtransCoreKit
//
//  Created by Akbar Taufiq Herlangga on 3/10/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTMerchantClient.h"
#import "VTConfig.h"
#import "VTNetworking.h"
#import "VTHelper.h"

@implementation VTMerchantClient

+ (id)sharedClient {
    // Idea stolen from http://www.galloway.me.uk/tutorials/singleton-classes/
    static VTMerchantClient *instance = nil;
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    
    return instance;
}

- (void)performCreditCardTransaction:(VTCTransactionData *)transaction completion:(void(^)(VTPaymentResult *result, NSError *error))completion {
    NSString *URL = [NSString stringWithFormat:@"%@/%@", [CONFIG merchantServerURL], @"charge"];
    
    [[VTNetworking sharedInstance] postToURL:URL header:[[CONFIG merchantAuth] dictinaryValue] parameters:[transaction dictionaryValue] callback:^(id response, NSError *error) {
        
        if (response) {
            VTPaymentResult *result = [[VTPaymentResult alloc] initWithPaymentResponse:response];
            if (completion) completion(result, error);
        } else {
            if (completion) completion(nil, error);
        }
    }];
}

- (void)saveRegisteredCard:(id)savedCard completion:(void(^)(id response, NSError *error))completion {
    NSString *URL = [NSString stringWithFormat:@"%@/%@", [CONFIG merchantServerURL], @"card/register"];
    [[VTNetworking sharedInstance] postToURL:URL header:[[CONFIG merchantAuth] dictinaryValue] parameters:savedCard callback:completion];
}

- (void)fetchMaskedCardsWithCompletion:(void(^)(NSArray *maskedCards, NSError *error))completion {
    NSString *URL = [NSString stringWithFormat:@"%@/%@", [CONFIG merchantServerURL], @"card"];
    [[VTNetworking sharedInstance] getFromURL:URL header:[[CONFIG merchantAuth] dictinaryValue] parameters:nil callback:^(id response, NSError *error) {
        
        NSMutableArray *result;
        if (response) {
            result = [NSMutableArray new];
            NSArray *rawCards = response[@"data"];
            for (id rawCard in rawCards) {
                VTMaskedCreditCard *card = [VTMaskedCreditCard maskedCardFromData:rawCard];
                [result addObject:card];
            }
        }
        if (completion) completion(result, error);
        
    }];
}

- (void)deleteMaskedCard:(VTMaskedCreditCard *)maskedCard completion:(void(^)(BOOL success, NSError *error))completion {
    NSString *URL = [NSString stringWithFormat:@"%@/%@/%@", [CONFIG merchantServerURL], @"card", maskedCard.savedTokenId];
    [[VTNetworking sharedInstance] deleteFromURL:URL header:[[CONFIG merchantAuth] dictinaryValue] parameters:nil callback:^(id response, NSError *error) {
        if (response) {
            if (completion) completion(true, error);
        } else {
            if (completion) completion(false, error);
        }
    }];
}

- (void)fetchMerchantAuthDataWithCompletion:(void(^)(id response, NSError *error))completion {
    NSString *URL = [NSString stringWithFormat:@"%@/auth", [CONFIG merchantServerURL]];
    [[VTNetworking sharedInstance] postToURL:URL parameters:nil callback:completion];
}

@end
