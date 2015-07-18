//
//  WorkLogList.m
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "WorkLogList.h"

@implementation WorkLogList

+(WorkLogList*) workLogList {
    return [[WorkLogList alloc] init];
}

-(instancetype) init {
    if(self = [super init]) {
        _list = [NSMutableArray array];
    }
    
    return self;
}

@end
