//
//  MemeCollectionViewCell.m
//  memefication
//
//  Created by David Tjokroaminoto on 11/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import "MemeCollectionViewCell.h"
@interface MemeCollectionViewCell()
{
            BOOL isLiked;
}
@end

@implementation MemeCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    CGRect screenSize = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, screenSize.size.width*0.5, screenSize.size.width*0.5)];
    
    int fontSize = IS_IPHONE_5 ? 14.0 : 18.0;
    
    _memeLabel = [[THLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _memeLabel.numberOfLines = 2;
    _memeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _memeLabel.font = [UIFont fontWithName:@"Impact" size:fontSize];
    _memeLabel.textColor = [UIColor whiteColor];
    _memeLabel.strokeSize = 2.0f;
    _memeLabel.strokeColor = [UIColor blackColor];
    
    _memeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.95, self.frame.size.height*0.95)];
    _memeImage.layer.borderWidth = 0.5f;
    _memeImage.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];

    _memeLike = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-45, 15, 25, 25)];
    [_memeLike setImage:[UIImage imageNamed:@"like-icon"] forState:UIControlStateNormal];
    [_memeLike addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _isCamera = NO;

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
    _thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]];
    
    _memeID = imageId;
    _memeImage.image = [[UIImage alloc] initWithData:_thumbnailData];
    _memeImage.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)likeAction:(UIButton *)sender {
    if (isLiked != YES) {
        [MemeHelper likeMeme:_memeID dislike:NO];
        [self setStatus:true];
        isLiked = YES;
    } else {
        [MemeHelper likeMeme:_memeID dislike:YES];
        [self setStatus:false];
        isLiked = NO;
    }
}

- (void)setStatus:(BOOL)isActive {
    isLiked = (isActive ? YES : NO);
    [_memeLike setImage:[UIImage imageNamed:(isActive ? @"like-active-icon" : @"like-icon")] forState:UIControlStateNormal];
}

- (void)setCamera {
    _isCamera = YES;
    _memeImage.image = [UIImage imageNamed:@"camera-image"];
    _memeLabel.text = @"";
    _memeLike.hidden = true;
    _memeImage.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

@end
