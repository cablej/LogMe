//
//  ClientList.m
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "ClientList.h"
#import "Client.h"
#import "WorkLog.h"
#import "WorkLogList.h"

@implementation ClientList

-(void) writeListToFile : (NSString*) fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    NSMutableArray *arrayToWrite = [NSMutableArray array];
    
    for(Client *c in self.list) {
        [arrayToWrite addObject:[NSMutableArray array]];
        NSMutableArray *clientWrite = [arrayToWrite lastObject];
        [clientWrite addObject:[c exportRawData]];
        [clientWrite addObject:[NSMutableArray array]];
        NSMutableArray *logsWrite = [clientWrite lastObject];
        for(WorkLog *l in c.logs.list) {
            [logsWrite addObject:[l exportRawData]];
        }
    }
    
    [arrayToWrite writeToFile:stringsPlistPath atomically:YES];
}

+(ClientList*) loadFromFile : (NSString*) fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    ClientList *list = [ClientList clientList];
    NSArray *rawData = [NSArray arrayWithContentsOfFile:stringsPlistPath];
    for(int i=0; i<rawData.count; i++) {
        NSArray *newClientRawData = rawData[i];
        NSArray *newClientInfoRaw = newClientRawData[0];
        NSArray *newClientLogs = newClientRawData[1];
        
        Client *newClient = [[Client alloc] init];
        newClient.name = newClientInfoRaw[0];
        newClient.rate = [newClientInfoRaw[1] floatValue];
        
        for(int i=0; i<newClientLogs.count; i++) {
            NSArray *rawLog = newClientLogs[i];
            WorkLog *newLog = [[WorkLog alloc] init];
            newLog.startTime = rawLog[0];
            newLog.endTime = rawLog[1];
            newLog.dollarsPerHour = [rawLog[2] intValue];
            [newClient.logs.list addObject:newLog];
        }
        
        [list.list addObject:newClient];
    }
    return list.list == nil? [ClientList clientList] : list;
}

+(ClientList*) clientList {
    return [[ClientList alloc] init];
}

-(instancetype) init {
    if(self = [super init]) {
        self.list = [NSMutableArray array];
    }
    
    return self;
}


@end
