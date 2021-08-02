//
//  IXWSCatalogAccess.h
//  IXCommons
//
//   Created by Alexis Porras on on 7/18/13.
//  Copyright (c) 2013 Ixaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APWSAccess : NSObject

+ (APWSAccess *)sharedInstance;
+ (void)restartService;
- (void)synchronizeDB;
@end
