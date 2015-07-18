//
//  WorkLog.m
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "WorkLog.h"

@implementation WorkLog
@synthesize startTime,endTime,dollarsPerHour;

/*-(void) storeWorkLogToFileNamed:(NSString *)fileName {
    
    NSMutableArray *rawData = [NSMutableArray arrayWithArray:[WorkLog loadAllRawDataFromFileNamed:fileName]];
    
    NSArray *variablesToStore = @[startTime, endTime, [NSNumber numberWithFloat:dollarsPerHour]];
    
    [rawData addObject:variablesToStore];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    [rawData writeToFile:stringsPlistPath atomically:YES];
}

+(void) storeArrayToFileNamed:(NSString *)fileName : (NSArray*) array{
    
    NSMutableArray *rawData = [NSMutableArray array];
    
    for(WorkLog *log in array) {
        
        NSArray *variablesToStore = @[log.startTime, log.endTime, [NSNumber numberWithFloat:log.dollarsPerHour]];
        
        [rawData addObject:variablesToStore];
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    [rawData writeToFile:stringsPlistPath atomically:YES];
}

+(NSArray *) loadAllWorkLogsFromFileNamed:(NSString *)fileName {
    
    NSArray *rawData = [self loadAllRawDataFromFileNamed:fileName];
    NSMutableArray *logs = [NSMutableArray array];
    
    for(NSArray *log in rawData) {
        NSDate *startDate = log[0];
        NSDate *endDate = log[1];
        float dollarsPerHour = [log[2] floatValue];
        [logs addObject:[[self alloc] initWithStartTime:startDate withEndTime:endDate withWage:dollarsPerHour]];
    }
    
    return logs;
    
}

+(NSArray *) loadAllRawDataFromFileNamed:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    NSArray *logs = [NSArray arrayWithContentsOfFile:stringsPlistPath];
    return logs;
}*/

-(NSArray*) exportRawData {
    return @[startTime, endTime, [NSNumber numberWithFloat:dollarsPerHour]];
}


-(instancetype) initWithStartTime : (NSDate*) start withEndTime : (NSDate*) end withWage : (float) wage {
    if(self = [super init]) {
        startTime = start;
        endTime = end;
        dollarsPerHour = wage;
    }
    
    return self;
}

-(instancetype) initWithStartTime : (NSDate*) start withWage : (float) wage {
    if(self = [super init]) {
        startTime = start;
        dollarsPerHour = wage;
    }
    
    return self;
}



#pragma mark Time Elapsed

-(NSString*) getFormattedTimeElapsed {
    NSTimeInterval totalTimeElapsed = [self getTimeElapsed];
    NSInteger ti = (NSInteger)totalTimeElapsed;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

-(NSString*) getFormattedTimeElapsedLong {
    NSTimeInterval totalTimeElapsed = [self getTimeElapsed];
    NSInteger ti = (NSInteger)totalTimeElapsed;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%ld hours, %ld minutes", (long)hours, (long)minutes];
}

-(NSString*) getFormattedTimeElapsedVeryLong {
    NSTimeInterval totalTimeElapsed = [self getTimeElapsed];
    NSInteger ti = (NSInteger)totalTimeElapsed;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%ld hours, %ld minutes, %ld seconds", (long)hours, (long)minutes, (long)seconds];
}

-(NSTimeInterval) getTimeElapsed {
    
    if(startTime == nil) return 0;
    else if(endTime != nil) return [endTime timeIntervalSinceDate:startTime];
    else return [[NSDate date] timeIntervalSinceDate:startTime];
}

-(NSString*) getFormattedEndDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString *stringFromDate = [formatter stringFromDate:endTime];
    
    return stringFromDate;
}

-(NSString*) getFormattedStartTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *stringFromDate = [formatter stringFromDate:startTime];
    
    return stringFromDate;
}


-(NSString*) getFormattedEndTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *stringFromDate = [formatter stringFromDate:endTime];
    
    return stringFromDate;
}

#pragma mark Money Made

-(float) getDollarsEarned {
    return [self getTimeElapsed]*(dollarsPerHour/3600); //it's per second!
}

-(NSString*) getFormattedDollarsEarned {
    return [NSString stringWithFormat:@"$%.2f", [self getDollarsEarned]];
}


@end
