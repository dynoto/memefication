//
//  MemeShareViewController.h
//  memefication
//
//  Created by David Tjokroaminoto on 13/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemeShareViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *memeImage;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


- (void)setRenderedImage:(UIImage *)image;
- (IBAction)doneAction:(id)sender;


@end
