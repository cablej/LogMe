//
//  AddClientPageController.m
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "AddClientPageController.h"
#import "Client.h"
#import "ClientList.h"
#import "Constants.h"

@implementation AddClientPageController

-(void) addClient:(NSString *)name :(float)wage {
    Client *newClient = [[Client alloc] init];
    newClient.name = name;
    newClient.rate = wage;
    ClientList *allClients = [ClientList loadFromFile:logFile];
    [allClients.list addObject:newClient];
    [allClients writeListToFile:logFile];
}

@end
