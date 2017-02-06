//
//  DetailViewController.m
//
//  Copyright (c) 2016 DuarteLopes. All rights reserved.
//

#import "PostViewController.h"
#import "MBProgressHUD.h"

@interface PostViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation PostViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.post.title;
    [self setupWebView];
}

- (void)setupWebView
{
    NSURL *url = [NSURL URLWithString:self.post.short_URL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
    [self.webView loadRequest:requestObj];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.webView
                                              animated:YES];
    hud.label.text = NSLocalizedString(@"Loading", nil);
    hud.userInteractionEnabled = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.webView
                         animated:YES];
}

@end
