//
//  PostsCollectionViewModel.m
//  FreshlyPressed
//
//  Created by Duarte Lopes on 29/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import "PostsCollectionViewModel.h"
#import "HTTPClient.h"
#import "PostCollectionViewCell.h"

static CGFloat PostCollectionViewCellHeight = 82.0;

@interface PostsCollectionViewModel() <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CoreDataManager *coreDataManager;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation PostsCollectionViewModel

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                       coreDataManager:(CoreDataManager *)coreDataManager
{
    self = [super init];
    
    if (self) {
        _collectionView = collectionView;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _coreDataManager = coreDataManager;
        
    }
    
    return self;
}

#pragma mark - Posts

- (void)loadPosts
{
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    
    [httpClient requestPostsWithSuccess:^(id _Nullable responseObject) {
        
        NSManagedObjectContext *context = [self.coreDataManager managedObjectContext];
        
        NSArray *posts = responseObject[PostsKey];
        
        for (id singlePost in posts) {
            NSError *error = [Post createOrUpdateWithDictionary:singlePost
                                                    withContext:context];
            
            if (error && [self.delegate respondsToSelector:@selector(showError:)]) {
                [self.delegate showError:error];
            }
        }
        
        [context save:nil];
        
        if ([self.delegate respondsToSelector:@selector(refreshFinished:error:)]) {
            [self.delegate refreshFinished:self
                                     error:nil];
        }
        
    } failure:^(NSError * _Nullable error) {
        if ([self.delegate respondsToSelector:@selector(refreshFinished:error:)]) {
            [self.delegate refreshFinished:self
                                     error:error];
        }
    }];
}

- (Post *)selectedPost
{
    NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
    Post *post;
    if (indexPaths.count > 0) {
        NSIndexPath *selectedIndexPath = [indexPaths firstObject];
        post = (Post *)[self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
    }
    
    return post;
}

- (void)setLayout:(PostsLayout)layout
{
    _layout = layout;
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                    [PostCollectionViewCell reuseIdentifier]
                                                                             forIndexPath:indexPath];
    
    Post *post = (Post *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureCellWithPost:post];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.collectionView.frame.size.width;
    
    if (self.layout == PostsLayoutGrid) {
        width = width / 2;
    }
    
    return CGSizeMake(width, PostCollectionViewCellHeight);
}

#pragma mark - CoreData

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.collectionView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *managedObjectContext = [self.coreDataManager managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:PostEntityKey
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:PostDateField
                                                                   ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {        
        if ([self.delegate respondsToSelector:@selector(showError:)]) {
            [self.delegate showError:error];
        }
    }
    
    return _fetchedResultsController;
}

@end
