//
//  AddLogController.m
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "AddLogController.h"
#import "Constants.h"
#import "Client.h"
#import "Constants.h"
#import "ClientList.h"

@implementation AddLogController {
    ClientList *allClients;
}

-(instancetype) init {
    if(self = [super init]) {
        allClients = [ClientList loadFromFile:logFile];
        _addedLog = [[WorkLog alloc] init];
        [_addedLog setDollarsPerHour:((Client*)allClients.list[[[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue]]).rate];
    }
    
    return self;
}

-(void) enteredStartTime:(NSDate *)startTime {
    _addedLog.startTime = startTime;
    _hasEnteredStartTime = YES;
}

-(void) enteredEndTime:(NSDate *)endTime {
    _addedLog.endTime = endTime;
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue] > (int) allClients.list.count - 1) {
        return;
    }
    Client *currentClient = allClients.list[[[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue]];
    [currentClient.logs.list addObject:_addedLog];
    [allClients writeListToFile:logFile];

}

@end
