//
//  AddLogController.h
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkLog.h"

@interface AddLogController : NSObject

@property BOOL hasEnteredStartTime;

@property(strong, nonatomic) WorkLog *addedLog;

-(void) enteredStartTime : (NSDate*) startTime;
-(void) enteredEndTime : (NSDate*) endTime;

@end
