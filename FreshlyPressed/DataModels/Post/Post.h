//
//  Post.h
//
//  Copyright (c) 2016 DuarteLopes. All rights reserved.
//

extern NSString * const DateKey;
extern NSString * const TitleKey;
extern NSString * const ImageKey;
extern NSString * const PostEntityKey;
extern NSString * const PostDateField;
extern NSString * const PostCellIdentifier;
extern NSString * const PostsKey;

/*!
 * @brief Post class with just the needed properties to fetch in coredata and present in the view.
 */
@interface Post : NSManagedObject

@property (nonatomic, copy) NSString *short_URL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *site_name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *postID;
@property (nonatomic, strong) NSNumber *siteID;

/*!
 * @brief Parse of data, insert of new Post or update of existing one into coredata.
 * @param dict Dictionary with post data.
 * @param context Context to insert/update to coredata.
 * @return An error if something wrong happens when fetching in coredata.
 */
+ (NSError *)createOrUpdateWithDictionary:(NSDictionary *)dict
                              withContext:(NSManagedObjectContext *)context;

@end
