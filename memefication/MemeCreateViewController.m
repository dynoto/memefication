//
//  MemeCreateViewController.m
//  memefication
//
//  Created by David Tjokroaminoto on 12/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import "MemeCreateViewController.h"

@interface MemeCreateViewController ()

@property (strong, nonatomic) UIImage *renderedImage;

@end

@implementation MemeCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    // Do any additional setup after loading the view.
    _memeImage.image = _selectedImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImageName:(UIImage *)image {
    _selectedImage = image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

- (IBAction)createAction:(id)sender {
    [self performSegueWithIdentifier:@"segueMemeCreateToShare" sender:self];
}

- (void)textChanged:(UITextField *)textField {
    THLabel *label = (textField.tag == 100) ? _memeTopLabel : _memeBottomLabel;
    
    label.text = [textField.text uppercaseString];
}

- (void)prepareUI {
    UIColor *blueColor = [UIColor colorWithRed:19/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
    
    _memeTopLabel.strokeSize = 2.0f;
    _memeTopLabel.strokeColor = [UIColor blackColor];
    
    _memeBottomLabel.strokeSize = _memeTopLabel.strokeSize;
    _memeBottomLabel.strokeColor = _memeTopLabel.strokeColor;
    
    
    [_memeTopText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    _memeTopText.adjustsFontSizeToFitWidth = TRUE;
    
    [_memeBottomText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    _memeBottomText.adjustsFontSizeToFitWidth = _memeTopText.adjustsFontSizeToFitWidth;
    
    _memeImageView.layer.borderWidth = 0.8f;
    _memeImageView.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0] CGColor];
    
    _backButton = [MemeHelper addRadius:_backButton color:nil];
    _createButton = [MemeHelper addRadius:_createButton color:[MemeHelper getColor:@"red"]];
}

- (void)mergeLabelWithImage {
    UIGraphicsBeginImageContextWithOptions(_memeImage.frame.size, FALSE, 0.0);
    [_memeImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, _memeTopLabel.frame.origin.x, 0);
    [_memeTopLabel.layer renderInContext:UIGraphicsGetCurrentContext()];

    CGContextTranslateCTM(context, 0, _memeBottomLabel.frame.origin.y);
    [_memeBottomLabel.layer renderInContext:UIGraphicsGetCurrentContext()];
    _renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    
//    UIImageWriteToSavedPhotosAlbum(_renderedImage, nil, nil, nil);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self mergeLabelWithImage];
    
    if ([segue.destinationViewController respondsToSelector:@selector(setRenderedImage:)]) {
        [segue.destinationViewController performSelector:@selector(setRenderedImage:) withObject:_renderedImage];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 100) {
        [_memeBottomText becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
