//
//  HTTPClient.m
//  FreshlyPressed
//
//  Created by Duarte Lopes on 24/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import "HTTPClient.h"
#import "AFHTTPSessionManager.h"

static NSString * const PostsURL = @"https://public-api.wordpress.com/rest/v1/freshly-pressed/?number=24";

@implementation HTTPClient

- (void)requestPostsWithSuccess:(void (^)(id _Nullable))success
                        failure:(void (^)(NSError * _Nonnull))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:PostsURL
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *operation, id responseObject) {
             
             success(responseObject);

         } failure:^(NSURLSessionTask *operation, NSError *error) {
             failure(error);
         }];
}

@end
