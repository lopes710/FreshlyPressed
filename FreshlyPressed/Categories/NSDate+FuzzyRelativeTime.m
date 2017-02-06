//
//  NSDate+FuzzyRelativeTime.m
//
//  Copyright (c) 2016 DuarteLopes. All rights reserved.
//

#import "NSDate+FuzzyRelativeTime.h"

@implementation NSDate (FuzzyRelativeTime)

- (NSCalendar *)calendar
{
    static NSCalendar *gregorian;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    });
    return gregorian;
}

- (NSString *)fuzzyRelativeTimeFromDate:(NSDate *)date
{
    NSCalendar *gregorian = self.calendar;
    
    NSUInteger unitFlags = NSCalendarUnitYear
                            | NSCalendarUnitMonth
                            | NSCalendarUnitDay
                            | NSCalendarUnitHour
                            | NSCalendarUnitMinute
                            | NSCalendarUnitSecond;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:self
                                                  toDate:date
                                                 options:0];
    NSString *dateComponentType;
    NSInteger stringNumber = 0;
    
    if ([components year]) {
        stringNumber = [components year];
        dateComponentType = NSLocalizedString(@"Year", nil);
    } else if ([components month]) {
        stringNumber = [components month];
        dateComponentType = NSLocalizedString(@"Month", nil);
    } else if ([components day]) {
        stringNumber = [components day];
        dateComponentType = NSLocalizedString(@"Day", nil);
    } else if ([components hour]) {
        stringNumber = [components hour];
        dateComponentType = NSLocalizedString(@"Hour", nil);
    } else if ([components minute]) {
        stringNumber = [components minute];
        dateComponentType = NSLocalizedString(@"Minute", nil);
    }
    
    NSString *returnValue;
    if (dateComponentType) {
        NSString *stringFormat = [NSString stringWithFormat:NSLocalizedString(@"DateComponentStringFormat", nil),
                                  dateComponentType,
                                  (stringNumber>1) ? NSLocalizedString(@"PluralCharacter", nil) : @""];
        returnValue = [NSString stringWithFormat:NSLocalizedString(stringFormat, @""), stringNumber];
    } else {
        returnValue = NSLocalizedString(@"JustNow", nil);
    }
    
    return returnValue;
}

- (NSString *)fuzzyRelativeTimeFromNow
{
    return [self fuzzyRelativeTimeFromDate:[NSDate date]];
}

@end
