//
//  MemeCollectionViewCell.m
//  memefication
//
//  Created by David Tjokroaminoto on 11/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import "MemeCollectionViewCell.h"

@implementation MemeCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    CGRect screenSize = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, screenSize.size.width*0.5, screenSize.size.width*0.5)];
    
    _memeLabel = [[THLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _memeLabel.font = [UIFont fontWithName:@"Impact" size:18.0];
    _memeLabel.textColor = [UIColor whiteColor];
    _memeLabel.strokeSize = 2.0f;
    _memeLabel.strokeColor = [UIColor blackColor];
    
    _memeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.9, self.frame.size.height*0.9)];

    _memeLike = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-45, 15, 25, 25)];
    [_memeLike setImage:[UIImage imageNamed:@"like-icon"] forState:UIControlStateNormal];
    [_memeLike addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_memeImage];
    [self addSubview:_memeLabel];
    [self addSubview:_memeLike];
    
    return self;
}

- (void)setLabelText:(NSString *)labelName {
    _memeLabel.text = labelName;
    [_memeLabel sizeToFit];
    _memeLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - _memeLabel.frame.size.height);
}

- (void)setAttributes:(NSString *)imageId imageName:(NSString *)imageName {
    _memeID = imageId;
    _memeImage.image = [UIImage imageNamed:imageName];
    _memeImage.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)likeAction:(UIButton *)sender {
    NSLog(@"%i",[MemeHelper likeMeme:_memeID]);
}

@end
