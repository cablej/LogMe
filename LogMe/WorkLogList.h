//
//  WorkLogList.h
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkLogList : NSObject

+(WorkLogList*) workLogList;

@property(strong, nonatomic) NSMutableArray *list;

@end
