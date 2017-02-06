//
//  PostTest.m
//  FreshlyPressed
//
//  Created by Duarte Lopes on 01/12/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Post.h"
#import "CoreDataManager.h"
#import "NSString+ISO8601DateFormatter.h"

@interface Post ()

- (void)updateFromDictionary:(NSDictionary *)dict;

@end

@interface PostTest : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContextForTests;
@property (nonatomic, copy) NSDictionary *dictExample;

@end

@implementation PostTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FreshlyPressed"
                                              withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    XCTAssertTrue([psc addPersistentStoreWithType:NSInMemoryStoreType
                                    configuration:nil
                                              URL:nil
                                          options:nil
                                            error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    self.managedObjectContextForTests = [[NSManagedObjectContext alloc] init];
    self.managedObjectContextForTests.persistentStoreCoordinator = psc;
    
    self.dictExample = @{
                         @"ID": @(374),
                         @"URL": @"https://ramaarya.wordpress.com/2014/03/29/photo-essay-the-hidden-graffiti-of-bandra/",
                         @"date": @"2014-03-29T17:50:30+00:00",
                         @"editorial": @{
                                 @"image": @"https://s1.wp.com/imgpress?w=252&url=http%2F2014%2F03%2_graffiti11.jpg"
                                 },
                         @"short_URL": @"http://wp.me/p1ILv-62",
                         @"site_ID": @(410409),
                         @"site_URL": @"https://ramaarya.wordpress.com",
                         @"title": @"photo essay: the hidden graffiti of bandra",
                         @"type": @"post",
                         @"site_name" : @"rama arya&#039;s blog"
                         };
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.´
    self.managedObjectContextForTests = nil;
    [super tearDown];
}

#pragma mark - CreateOrUpdateWithDictionary

- (void)testCreateOrUpdateWithEmptyDictionary
{
    // create and save
    [Post createOrUpdateWithDictionary:@{}
                           withContext:self.managedObjectContextForTests];
    
    NSNumber *postID = @(374);
    NSNumber *siteID = @(410409);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PostEntityKey];
    request.predicate = [NSPredicate predicateWithFormat:@"(postID = %@) AND (siteID = %@)", postID, siteID];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:DateKey
                                                              ascending:YES]];
    request.fetchLimit = 1;
    
    NSError *error;
    NSArray *results = [self.managedObjectContextForTests executeFetchRequest:request
                                                                        error:&error];
    
    Post *post;
    if (results.count > 0) {
        post = (Post *)[results objectAtIndex:0];
    }
    
    XCTAssertNil(post);
}

- (void)testCreateOrUpdateWithDictionaryPostID
{
    // create and save
    [Post createOrUpdateWithDictionary:self.dictExample
                           withContext:self.managedObjectContextForTests];
    
    NSNumber *postID = @(710);
    NSNumber *siteID = @(483934);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PostEntityKey];
    request.predicate = [NSPredicate predicateWithFormat:@"(postID = %@) AND (siteID = %@)", postID, siteID];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:DateKey
                                                              ascending:YES]];
    request.fetchLimit = 1;
    
    NSError *error;
    NSArray *results = [self.managedObjectContextForTests executeFetchRequest:request
                                                                        error:&error];
    
    Post *post;
    if (results.count > 0) {
        post = (Post *)[results objectAtIndex:0];
    }
    
    XCTAssertNil(post);
}

- (void)testCreateOrUpdateWithDictionary
{
    // create and save
    [Post createOrUpdateWithDictionary:self.dictExample
                           withContext:self.managedObjectContextForTests];
    
    NSNumber *postID = @(374);
    NSNumber *siteID = @(410409);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PostEntityKey];
    request.predicate = [NSPredicate predicateWithFormat:@"(postID = %@) AND (siteID = %@)", postID, siteID];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:DateKey
                                                              ascending:YES]];
    request.fetchLimit = 1;
    
    NSError *error;
    NSArray *results = [self.managedObjectContextForTests executeFetchRequest:request
                                                                        error:&error];
    
    Post *post;
    if (results.count > 0) {
        post = (Post *)[results objectAtIndex:0];
    }
    
    XCTAssertNotNil(post);
    XCTAssertEqualObjects(post.short_URL, @"http://wp.me/p1ILv-62");
    XCTAssertEqualObjects(post.title, @"photo essay: the hidden graffiti of bandra");
    XCTAssertEqualObjects(post.site_name, @"rama arya&#039;s blog");
    XCTAssertEqualObjects(post.image, @"https://s1.wp.com/imgpress?w=252&url=http%2F2014%2F03%2_graffiti11.jpg");
    NSDate *date = [@"2014-03-29T17:50:30+00:00" iso8601Value];
    XCTAssertEqual([post.date timeIntervalSinceReferenceDate], [date timeIntervalSinceReferenceDate]);
}

#pragma mark - UpdateFromDictionary

- (void)testUpdateFromEmptyDictionary
{
    Post *post = [[Post alloc] initWithContext:self.managedObjectContextForTests];
    [post updateFromDictionary:@{}];
    
    XCTAssertNotNil(post);
    XCTAssertEqualObjects(post.postID, @(0));
    XCTAssertEqualObjects(post.siteID, @(0));
    XCTAssertEqualObjects(post.short_URL, @"");
    XCTAssertEqualObjects(post.title, @"");
    XCTAssertEqualObjects(post.site_name, @"");
    XCTAssertNil(post.image);
    XCTAssertNil(post.date);
}

- (void)testUpdateFromDictionary
{
    Post *post = [[Post alloc] initWithContext:self.managedObjectContextForTests];
    [post updateFromDictionary:self.dictExample];
    
    XCTAssertNotNil(post);
    XCTAssertEqualObjects(post.postID, @(0));
    XCTAssertEqualObjects(post.siteID, @(0));
    XCTAssertEqualObjects(post.short_URL, @"http://wp.me/p1ILv-62");
    XCTAssertEqualObjects(post.title, @"photo essay: the hidden graffiti of bandra");
    XCTAssertEqualObjects(post.site_name, @"rama arya&#039;s blog");
    XCTAssertEqualObjects(post.image, @"https://s1.wp.com/imgpress?w=252&url=http%2F2014%2F03%2_graffiti11.jpg");
    NSDate *date = [@"2014-03-29T17:50:30+00:00" iso8601Value];
    XCTAssertEqual([post.date timeIntervalSinceReferenceDate], [date timeIntervalSinceReferenceDate]);
}

@end
