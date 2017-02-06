//
//  NSDictionary+SafeAccess.m
//  FreshlyPressed
//
//  Created by Duarte Lopes on 29/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import "NSDictionary+SafeAccess.h"

@implementation NSDictionary (SafeAccess)

- (id)valueForKey:(NSString *)key
         ifKindOf:(Class)class
     defaultValue:(id)defaultValue
{
    id obj = [self objectForKey:key];
    
    return [obj isKindOfClass:class] ? obj : defaultValue;
}

@end
