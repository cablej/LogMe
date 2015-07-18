//
//  LoggingController.h
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggingController : NSObject

-(void) startLogging;
-(void) endLogging;

-(NSString*) getFormattedTimeElapsed;
-(NSTimeInterval) getTimeElapsed;

-(BOOL) isLogging;

-(float) getDollarsEarned;
-(NSString*) getFormattedDollarsEarned;

-(NSString*) currentClientName;

-(void) loadClients;

-(BOOL) currentClientIsBeyondBounds;

@end
