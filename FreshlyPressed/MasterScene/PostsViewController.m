//
//  MasterViewController.m
//
//  Copyright (c) 2016 DuarteLopes. All rights reserved.
//

#import "PostsViewController.h"
#import "PostViewController.h"
#import "Post.h"
#import "PostsCollectionViewModel.h"
#import "MBProgressHUD.h"
#import "SCLAlertView.h"

static NSString * const HamburgerKey = @"hamburger";
static NSString * const GridKey = @"grid";

@interface PostsViewController() <PostsCollectionViewModelDelegate>

@property (nonatomic, strong) PostsCollectionViewModel *collectionModel;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation PostsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupCollectionView];
}

- (void)setupNavigationBar
{
    UIBarButtonItem *viewTypeButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:GridKey]
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:self
                                                                          action:@selector(contentViewChange)];
    self.navigationItem.leftBarButtonItem = viewTypeButtonItem;
    
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                  target:self
                                                                                  action:@selector(refreshPosts)];
    self.navigationItem.rightBarButtonItem = reloadButton;
}

- (void)setupCollectionView
{
    self.collectionModel = [[PostsCollectionViewModel alloc] initWithCollectionView:self.collectionView
                                                                    coreDataManager:self.coreDataManager];
    self.collectionModel.delegate = self;
    [self.collectionModel loadPosts];
}

#pragma mark - Private

- (void)refreshPosts
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    hud.label.text = NSLocalizedString(@"Loading", nil);
    hud.userInteractionEnabled = NO;
    
    [self.collectionModel loadPosts];
}

- (void)showErrorAlert:(NSError *)error
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert showError:self
               title:NSLocalizedString(@"ErrorOccurred", nil)
            subTitle:[NSString stringWithFormat:@"%@", [error localizedDescription]]
    closeButtonTitle:NSLocalizedString(@"OK", nil)
            duration:0.0];
}

- (void)contentViewChange
{
    if (self.collectionModel.layout == PostsLayoutGrid) {
        self.collectionModel.layout = PostsLayoutTable;
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:GridKey];
    } else {
        self.collectionModel.layout = PostsLayoutGrid;
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:HamburgerKey];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        Post *post = self.collectionModel.selectedPost;
        PostViewController *postViewController = (PostViewController *)segue.destinationViewController;
        postViewController.post = post;
    }
}

#pragma mark - PostsCollectionViewModelDelegate

- (void)refreshFinished:(PostsCollectionViewModel *)postsCollectionViewModel
                  error:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view
                         animated:YES];
}

- (void)showError:(NSError *)error {
    [self showErrorAlert:error];
}

@end
