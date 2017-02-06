//
//  CoreDataManager.h
//  FreshlyPressed
//
//  Created by Duarte Lopes on 24/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

/*!
 *  @brief The core data stack is added in the AppDelegate automatically. This class was created to 
 *         keep the AppDelegate clean.
 */
@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/*!
 * @brief Saving context to coreData
 * @return An error if occurs.
 */
- (NSError *)saveContext;

@end
