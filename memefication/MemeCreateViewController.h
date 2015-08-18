//
//  MemeCreateViewController.h
//  memefication
//
//  Created by David Tjokroaminoto on 12/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <THLabel/THLabel.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "MemeHelper.h"

@interface MemeCreateViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *memeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *memeImage;
@property (weak, nonatomic) IBOutlet THLabel *memeTopLabel;
@property (weak, nonatomic) IBOutlet THLabel *memeBottomLabel;
@property (weak, nonatomic) IBOutlet UITextField *memeTopText;
@property (weak, nonatomic) IBOutlet UITextField *memeBottomText;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong, nonatomic) UIImage *selectedImage;


- (IBAction)backAction:(id)sender;
- (void)setImageName:(UIImage *)image;


@end
