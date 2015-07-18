//
//  WorkLog.h
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkLog : NSObject

/*+(NSArray *) loadAllWorkLogsFromFileNamed : (NSString *) fileName;
-(void) storeWorkLogToFileNamed : (NSString *) fileName;
+(void) storeArrayToFileNamed : (NSString *) fileName : (NSArray*) array;*/
-(NSArray *) exportRawData;



@property(strong, nonatomic) NSDate *startTime;
@property(strong, nonatomic) NSDate *endTime;

@property float dollarsPerHour;

-(NSString*) getFormattedTimeElapsed;
-(NSTimeInterval) getTimeElapsed;
-(NSString*) getFormattedTimeElapsedLong;
-(NSString*) getFormattedTimeElapsedVeryLong;

-(float) getDollarsEarned;
-(NSString*) getFormattedDollarsEarned;

-(NSString *) getFormattedEndDate;
-(NSString *) getFormattedEndTime;
-(NSString *) getFormattedStartTime;

@end
