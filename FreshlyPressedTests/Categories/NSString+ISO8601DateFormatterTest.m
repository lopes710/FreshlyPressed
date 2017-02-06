//
//  NSString+ISO8601DateFormatterTest.m
//  FreshlyPressed
//
//  Created by Duarte Lopes on 03/12/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+ISO8601DateFormatter.h"

@interface NSString_ISO8601DateFormatterTest : XCTestCase

@end

@implementation NSString_ISO8601DateFormatterTest

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

- (void)testIso8601ValueWrongFormat
{
    NSString *dateStringExample;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = nil;
    NSDate *dateExample = [formatter dateFromString:dateStringExample];
    
    NSDate *dateTest = [dateStringExample iso8601Value];
    
    XCTAssertEqual([dateExample timeIntervalSinceReferenceDate], [dateTest timeIntervalSinceReferenceDate]);
}

- (void)testIso8601ValueEmpty
{
    NSString *dateStringExample = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZ";
    NSDate *dateExample = [formatter dateFromString:dateStringExample];
    
    NSDate *dateTest = [dateStringExample iso8601Value];
    
    XCTAssertEqual([dateExample timeIntervalSinceReferenceDate], [dateTest timeIntervalSinceReferenceDate]);
}

- (void)testIso8601Value
{
    NSString *dateStringExample = @"2014-03-29T17:50:30+00:00";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZ";
    NSDate *dateExample = [formatter dateFromString:dateStringExample];

    NSDate *dateTest = [dateStringExample iso8601Value];
    
    XCTAssertEqual([dateExample timeIntervalSinceReferenceDate], [dateTest timeIntervalSinceReferenceDate]);
}

@end
