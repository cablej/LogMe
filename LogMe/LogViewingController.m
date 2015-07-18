//
//  LogViewingController.m
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "LogViewingController.h"
#import "WorkLog.h"
#import "Constants.h"
#import "Client.h"

@implementation LogViewingController

@synthesize allClients;

-(instancetype) init {
    if(self = [super init]) {
        
    }
    
    return self;
}

-(void) loadClientsFromFile:(NSString *)fileName {
    allClients = [ClientList loadFromFile:fileName];
}

-(void) removeLogAtIndex:(int)index {
    Client *currentClient = allClients.list[[[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue]];
    [currentClient.logs.list removeObjectAtIndex:index];
    [allClients writeListToFile:logFile];
}

-(BOOL) currentClientIsBeyondBounds {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue] > (int) allClients.list.count - 1;
}

@end
