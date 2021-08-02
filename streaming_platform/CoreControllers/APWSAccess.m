//
//  IXWSCatalogAccess.m
//  IXCommons
//
//   Created by Alexis Porras on on 7/18/13.
//  Copyright (c) 2013 Ixaya. All rights reserved.
//

#import "APWSAccess.h"
#import "FDKeychain.h"

@interface APWSAccess (){
    NSDate *lastSyncStart;
}
@end

#define USER_DEFAULTS_FIREBASE_TOKEN @"USER_DEFAULTS_FIREBASE_TOKEN"

@implementation APWSAccess


static NSString *_pushToken;
static APWSAccess *_dataAccess;
+ (APWSAccess *)sharedInstance {
    if (_dataAccess == nil){
        _dataAccess = [[APWSAccess alloc] init];
    }
    
    return _dataAccess;
}

+ (void)resetInstance {
    _dataAccess = [[APWSAccess alloc] init];
}

+ (void)restartService
{
    _dataAccess = nil;
}

- (void)downloadMovies
{
    //serie
    [[APWSRequest sharedInstance] POST:@"i=tt0944947" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Movie" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944946" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Movie" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    //movie
    [[APWSRequest sharedInstance] POST:@"i=tt0944948" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Movie" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944954" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Movie" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944958" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Movie" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
}

- (void)downloadChapters{
    [[APWSRequest sharedInstance] POST:@"i=tt0944947&season=1&episode=1" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944947&season=1&episode=2" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944947&season=1&episode=3" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944947&season=1&episode=4" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944947&season=2&episode=1" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944947&season=2&episode=2" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944947&season=2&episode=3" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944947&season=2&episode=4" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944946&season=1&episode=1" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944946&season=1&episode=2" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944946&season=1&episode=3" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
    
    [[APWSRequest sharedInstance] POST:@"i=tt0944946&season=1&episode=4" parameters:nil completion:^(NSDictionary* responseObject, NSError * error) {
        if (responseObject){
            [[APCDDataAccess sharedInstance] processFromServer:responseObject forEntity:@"Chapter" ignoreEnabled:NO];
            [[APCDDataAccess sharedInstance] saveContext];
        }
    }];
}

#pragma mark Sync DB
- (void)synchronizeDB
{
    [APCDDataAccess sharedInstance];

    if (lastSyncStart && [lastSyncStart timeIntervalSinceNow] >= -300)
        return;

    lastSyncStart = [NSDate date];
    
    [self downloadMovies];
    [self downloadChapters];
}

@end
