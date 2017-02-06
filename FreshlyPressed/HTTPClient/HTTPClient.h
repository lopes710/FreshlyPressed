//
//  HTTPClient.h
//  FreshlyPressed
//
//  Created by Duarte Lopes on 24/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

@interface HTTPClient : NSObject

/*!
 * @brief A http request to retrieve posts
 * @param success Successful block
 * @param failure Failure block
 */
- (void)requestPostsWithSuccess:(nullable void (^)(id _Nullable responseObject))success
                        failure:(nullable void (^)(NSError * _Nullable error))failure;

@end
