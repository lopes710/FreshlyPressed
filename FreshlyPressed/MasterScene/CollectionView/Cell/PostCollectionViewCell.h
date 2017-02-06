//
//  PostCollectionViewCell.h
//  FreshlyPressed
//
//  Created by Duarte Lopes on 29/11/2016.
//  Copyright © 2016 DuarteLopes. All rights reserved.
//

#import "Post.h"

@interface PostCollectionViewCell : UICollectionViewCell

/*!
 * @brief The PostCollectionViewCell thumb imageView.
 */
@property (nonatomic, weak) IBOutlet UIImageView *thumbImageView;

/*!
 * @brief A class method to use as identifier of the class (same name as class)
 * @return The name of the class
 */
+ (NSString *)reuseIdentifier;

/*!
 * @brief The PostCollectionViewCell thumb imageView.
 * @param post The Post object to populate the cell
 */
- (void)configureCellWithPost:(Post *)post;

@end
