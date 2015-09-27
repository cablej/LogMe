//
//  ClientPageController.h
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClientList.h"

@interface ClientPageController : NSObject

@property(strong, nonatomic) ClientList *clientList;
-(void) removeClientAtIndex:(int)index;

-(void) loadClientList;

@end
