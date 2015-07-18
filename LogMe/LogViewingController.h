//
//  LogViewingController.h
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClientList.h"

@interface LogViewingController : NSObject

@property(strong, nonatomic) ClientList *allClients;

-(void) loadClientsFromFile : (NSString *) fileName;

-(void) removeLogAtIndex : (int) index;

@end
