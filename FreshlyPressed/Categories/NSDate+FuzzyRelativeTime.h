//
//  NSDate+FuzzyRelativeTime.h
//
//  Copyright (c) 2016 DuarteLopes. All rights reserved.
//

@interface NSDate (FuzzyRelativeTime)

/*!
 * @brief Relative time from now.
 * @return The relative date from now in a string.
 */
- (NSString *)fuzzyRelativeTimeFromNow;

@end
