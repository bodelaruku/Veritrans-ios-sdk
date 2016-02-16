//
//  VTUser.h
//  VTDirectCoreKit
//
//  Created by Nanang Rafsanjani on 2/16/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTAddress.h"

@interface VTUser : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSString *phone;
@property (nonatomic, readonly) VTAddress *address;
@property (nonatomic, readonly) VTAddress *billingAddress;

@end
