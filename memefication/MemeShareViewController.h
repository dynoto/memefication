//
//  MemeShareViewController.h
//  memefication
//
//  Created by David Tjokroaminoto on 13/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Social/Social.h"
#import "MemeHelper.h";

@interface MemeShareViewController : UIViewController <UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *memeImage;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) UIDocumentInteractionController *docController;


- (void)setRenderedImage:(UIImage *)image;
- (IBAction)doneAction:(id)sender;
- (IBAction)socialShareAction:(id)sender;


@end
