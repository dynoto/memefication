//
//  MemeCollectionViewCell.h
//  memefication
//
//  Created by David Tjokroaminoto on 11/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <THLabel/THLabel.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "MemeHelper.h"

@interface MemeCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet THLabel *memeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *memeImage;
@property (strong, nonatomic) IBOutlet UIButton *memeLike;
@property (strong, nonatomic) NSString *memeID;
@property BOOL isCamera;

- (void)setCamera;
- (void)setLabelText:(NSString*)labelName;
- (void)setAttributes:(NSString*)imageId imageName:(NSString*)imageName;
- (void)setStatus:(BOOL)isActive;
- (void)likeAction:(UIButton *)sender;

@end
