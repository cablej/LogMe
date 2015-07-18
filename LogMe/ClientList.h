//
//  ClientList.h
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientList : NSObject

-(void) writeListToFile : (NSString*) fileName;
+(ClientList*) loadFromFile : (NSString*) fileName;
+(ClientList*) clientList;

@property(strong, nonatomic) NSMutableArray *list;

@end
