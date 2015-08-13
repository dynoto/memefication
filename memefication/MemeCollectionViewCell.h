//
//  MemeCollectionViewCell.h
//  memefication
//
//  Created by David Tjokroaminoto on 11/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"

@interface MemeCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet THLabel *memeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *memeImage;
@property (strong, nonatomic) NSString *memeID;

-(void)setLabelText:(NSString*)labelName;
-(void)setImage:(NSString*)imageName;

@end
