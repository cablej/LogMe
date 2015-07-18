//
//  ClientPageController.m
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "ClientPageController.h"
#import "Constants.h"

@implementation ClientPageController

-(instancetype) init {
    if(self = [super init]) {
        [self loadClientList];
    }
    
    return self;
}

-(void) loadClientList {
    _clientList = [ClientList loadFromFile:logFile];
}

@end
