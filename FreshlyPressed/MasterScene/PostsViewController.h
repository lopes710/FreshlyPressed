//
//  MasterViewController.h
//
//  Copyright (c) 2016 DuarteLopes. All rights reserved.
//
#import "CoreDataManager.h"

@interface PostsViewController : UIViewController

/*!
 * @brief CoreDataManager object.
 */
@property (nonatomic, strong) CoreDataManager *coreDataManager;

/*!
 * @brief Method to present alert with a specific error.
 * @param error The resulted error.
 */
- (void)showErrorAlert:(NSError *)error;

@end
