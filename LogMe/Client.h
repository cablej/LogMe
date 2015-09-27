//
//  Client.h
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkLogList.h"

@interface Client : NSObject

@property(strong, nonatomic) NSString *name;
@property float rate;

@property(strong, nonatomic) WorkLogList *logs;

-(NSArray*) exportRawData;

@end
