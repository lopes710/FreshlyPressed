//
//  NSString+ISO8601DateFormatter.m
//
//  Copyright (c) 2016 DuarteLopes. All rights reserved.
//

#import "NSString+ISO8601DateFormatter.h"

@implementation NSString (ISO8601DateFormatter)

- (NSDateFormatter *)formatter
{
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZ";
    });
    return formatter;
}

- (NSDate *)iso8601Value
{
    NSString *theDate = self;
    NSDate *date = [self.formatter dateFromString:theDate];
    
    return date;
}

@end
