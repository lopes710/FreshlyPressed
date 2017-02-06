//
//  NSDictionary+SafeAccess.h
//  FreshlyPressed
//
//  Created by Duarte Lopes on 29/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

@interface NSDictionary (SafeAccess)

/*!
 * @brief Check access to NSDictionary.
 * @param key The NSDictionary key.
 * @param class The class type of the NSDictionary content.
 * @param defaultValue Default value if content is not what expected.
 * @return The object or the defaultValue.
 */
- (id)valueForKey:(NSString *)key
         ifKindOf:(Class)class
     defaultValue:(id)defaultValue;

@end
