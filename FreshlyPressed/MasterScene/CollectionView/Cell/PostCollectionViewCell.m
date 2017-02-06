//
//  PostCollectionViewCell.m
//  FreshlyPressed
//
//  Created by Duarte Lopes on 29/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import "PostCollectionViewCell.h"
#import "NSDate+FuzzyRelativeTime.h"
#import "UIImageView+AFNetworking.h"

static NSString * const Placeholder = @"placeholder";

@interface PostCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end

@implementation PostCollectionViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)configureCellWithPost:(Post *)post
{
    self.titleLabel.text = post.title ? : NSLocalizedString(@"NoTitle", nil);
    self.dateLabel.text = [post.date fuzzyRelativeTimeFromNow];
    
    NSURL *url = [NSURL URLWithString:post.image];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:Placeholder];
    
    // Asynchronous call
    __weak typeof(self) weakSelf = self;
    [self.thumbImageView setImageWithURLRequest:request
                               placeholderImage:placeholderImage
                                        success:^(NSURLRequest *request,
                                                  NSHTTPURLResponse *response,
                                                  UIImage *image) {
                                            
                                            __strong typeof(self) strongSelf = weakSelf;
                                            strongSelf.thumbImageView.image = image;
                                            [strongSelf setNeedsLayout];
                                        } failure:nil];
}

@end
