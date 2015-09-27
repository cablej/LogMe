//
//  Client.m
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "Client.h"

@implementation Client

-(instancetype) init {
    if(self = [super init]) {
        _logs = [WorkLogList workLogList];
    }
    
    return self;
}

-(NSArray*) exportRawData {
    return @[_name, [NSNumber numberWithFloat:_rate]];
}

@end
