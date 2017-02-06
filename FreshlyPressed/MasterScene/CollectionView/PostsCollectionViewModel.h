//
//  PostsCollectionViewModel.h
//  FreshlyPressed
//
//  Created by Duarte Lopes on 29/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import "Post.h"
#import "CoreDataManager.h"
@class PostsCollectionViewModel;

/*!
 * @typedef PostsLayout
 * @brief The type of post view.
 * @constant PostsLayoutTable A list view of the posts.
 * @constant PostsLayoutGrid A grid view of the posts.
 */
typedef NS_ENUM(NSInteger, PostsLayout) {
    PostsLayoutTable,
    PostsLayoutGrid
};

@protocol PostsCollectionViewModelDelegate <NSObject>

/*!
 * @brief Message to indicate that refresh ended operation.
 * @param postsCollectionViewModel The view model where the operation occurs.
 * @param error The error if refresh operation failed.
 */
- (void)refreshFinished:(PostsCollectionViewModel *)postsCollectionViewModel
                  error:(NSError *)error;

@optional
/*!
 * @brief Error message to show an alert.
 * @param error The error.
 */
- (void)showError:(NSError *)error;

@end

@interface PostsCollectionViewModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/*!
 * @brief The PostsLayout definition.
 */
@property (nonatomic, assign) PostsLayout layout;

/*!
 * @brief The delegate of PostsCollectionViewModelDelegate protocol.
 */
@property (nonatomic, weak) id<PostsCollectionViewModelDelegate> delegate;

/*!
 * @brief The selected post.
 */
@property (nonatomic, strong) Post *selectedPost;

/*!
 * @brief The initializer of the PostsCollectionViewModel
 * @param collectionView The collectionView used to present the list and grid views.
 * @param coreDataManager The coreDataManager object for coredata functionalities.
 * @return The PostsCollectionViewModel object
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                       coreDataManager:(CoreDataManager *)coreDataManager;

/*!
 * @brief Method to http request posts and insert/update to coredata
 */
- (void)loadPosts;

@end
