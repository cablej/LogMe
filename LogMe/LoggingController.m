//
//  LoggingController.m
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "LoggingController.h"
#import "WorkLog.h"
#import "Constants.h"
#import "ClientList.h"
#import "Client.h"
#import "WorkLogList.h"

@implementation LoggingController {
    WorkLog *currentLog;
    ClientList *allClients;
}

-(instancetype) init {
    if(self = [super init]) {
        currentLog = [[WorkLog alloc] init];
        [self loadClients];
        if(![self currentClientIsBeyondBounds]) [currentLog setDollarsPerHour:((Client*)allClients.list[[[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue]]).rate];
        /*allClients = [ClientList clientList];
        [allClients writeListToFile:logFile];*/
    }
    return self;
}

-(void) loadClients {
    allClients = [ClientList loadFromFile:logFile];
}

#pragma mark Logging Functions

-(BOOL) isLogging {
    return currentLog.startTime != nil;
}

-(BOOL) currentClientIsBeyondBounds {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue] > (int) allClients.list.count - 1;
}

-(void) startLogging {
    
    [self restartCurrentLog];
    
    currentLog.startTime = [NSDate date];
    NSLog(@"Started Logging");
}

-(void) restartCurrentLog {
    
    currentLog = [[WorkLog alloc] init];
    [currentLog setDollarsPerHour:15];
}

-(void) endLogging {
    
    if(currentLog.startTime == nil) return;
    
    currentLog.endTime = [NSDate date];
    
    if([self currentClientIsBeyondBounds]) {
        [self restartCurrentLog];
        return;
    }
    Client *currentClient = allClients.list[[[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue]];
    [currentClient.logs.list addObject:currentLog];
    [allClients writeListToFile:logFile];
    
    
    NSTimeInterval totalTimeElapsed = [self getTimeElapsed];
    NSLog(@"Stopped Logging : %f", totalTimeElapsed);
    
    [self restartCurrentLog];
}

#pragma mark Time Elapsed

-(NSString*) getFormattedTimeElapsed {
    return [currentLog getFormattedTimeElapsed];
}

-(NSTimeInterval) getTimeElapsed {
    return [currentLog getTimeElapsed];
}

#pragma mark Money Made

-(float) getDollarsEarned {
    return [currentLog getDollarsEarned];
}

-(NSString*) getFormattedDollarsEarned {
    return [currentLog getFormattedDollarsEarned];
}

-(NSString*) currentClientName {
    return ((Client*)allClients.list[[[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue]]).name;
}


@end
