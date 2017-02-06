//
//  NSDate+FuzzyRelativeTimeTest.m
//  FreshlyPressed
//
//  Created by Duarte Lopes on 03/12/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+FuzzyRelativeTime.h"

@interface NSDate ()

- (NSString *)fuzzyRelativeTimeFromDate:(NSDate *)date;

@end

@interface NSDate_FuzzyRelativeTimeTest : XCTestCase

@end

@implementation NSDate_FuzzyRelativeTimeTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFuzzyRelativeTimeFromDateEmpty
{    
    // now date
    NSString *dateNowStringExample = @"2016-12-03T15:14:50GMT";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZ";
    NSDate *dateNowExample = [formatter dateFromString:dateNowStringExample];
    
    // post date
    NSString *dateStringExample = nil;
    NSDate *dateExample = [formatter dateFromString:dateStringExample];
    
    NSString *resultedDateString = [dateExample fuzzyRelativeTimeFromDate:dateNowExample];
    
    XCTAssertNil(resultedDateString);
}

- (void)testFuzzyRelativeTimeFromDate
{
    NSString *dateString = @"about 7 months ago";
    
    // now date
    NSString *dateNowStringExample = @"2016-12-03T15:14:50GMT";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZ";
    NSDate *dateNowExample = [formatter dateFromString:dateNowStringExample];
    
    // post date
    NSString *dateStringExample = @"2016-04-28T04:29:04GMT+01:00";
    NSDate *dateExample = [formatter dateFromString:dateStringExample];
    
    NSString *resultedDateString = [dateExample fuzzyRelativeTimeFromDate:dateNowExample];
    
    XCTAssertEqualObjects(dateString, resultedDateString);
}

@end
