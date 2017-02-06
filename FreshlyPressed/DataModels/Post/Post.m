//
//  Post.m
//
//  Copyright (c) 2016 DuarteLopes. All rights reserved.
//

#import "Post.h"
#import "NSString+ISO8601DateFormatter.h"
#import "NSDictionary+SafeAccess.h"

NSString * const DateKey = @"date";
NSString * const TitleKey = @"title";
NSString * const ImageKey = @"image";
NSString * const PostEntityKey = @"Post";
NSString * const PostDateField = @"date";
NSString * const PostCellIdentifier = @"PostCell";
NSString * const PostsKey = @"posts";
static NSString * const IDKey = @"ID";
static NSString * const siteIDKey = @"site_ID";
static NSString * const EditorialKey = @"editorial";
static NSString * const ShortURLKey = @"short_URL";
static NSString * const SiteNameKey = @"site_name";

@implementation Post

@dynamic short_URL;
@dynamic title;
@dynamic site_name;
@dynamic image;
@dynamic date;
@dynamic postID;
@dynamic siteID;

+ (NSError *)createOrUpdateWithDictionary:(NSDictionary *)dict
                         withContext:(NSManagedObjectContext *)context
{
    NSNumber *postID = [dict valueForKey:IDKey
                                ifKindOf:[NSNumber class]
                            defaultValue:@(0)];
    NSNumber *siteID = [dict valueForKey:siteIDKey
                                ifKindOf:[NSNumber class]
                            defaultValue:@(0)];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PostEntityKey];
    request.predicate = [NSPredicate predicateWithFormat:@"(postID = %@) AND (siteID = %@)", postID, siteID];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:DateKey
                                                              ascending:YES]];
    request.fetchLimit = 1;
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request
                                              error:&error];
    if(error != nil) {
        return error;
    }
    
    Post *post;
    if ([results count] > 0) {
        post = (Post *)[results objectAtIndex:0];
    } else {
        post = (Post *)[NSEntityDescription insertNewObjectForEntityForName:PostEntityKey
                                                     inManagedObjectContext:context];
        post.postID = postID;
        post.siteID = siteID;
    }
    
    [post updateFromDictionary:dict];
    
    return nil;
}

- (void)updateFromDictionary:(NSDictionary *)dict
{
    NSDictionary *editorial = [dict valueForKey:EditorialKey
                                       ifKindOf:[NSDictionary class]
                                   defaultValue:nil];
    
    self.short_URL = [dict valueForKey:ShortURLKey
                              ifKindOf:[NSString class]
                          defaultValue:@""];
    
    self.title = [dict valueForKey:TitleKey
                          ifKindOf:[NSString class]
                      defaultValue:@""];
    
    self.site_name = [dict valueForKey:SiteNameKey
                              ifKindOf:[NSString class]
                          defaultValue:@""];
    
    NSString *dateString = [dict valueForKey:DateKey
                                    ifKindOf:[NSString class]
                                defaultValue:nil];
    self.date = [dateString iso8601Value];
    
    self.image = [editorial valueForKey:ImageKey
                               ifKindOf:[NSString class]
                           defaultValue:nil];
}

@end
