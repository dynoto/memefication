//
//  MemeShareViewController.m
//  memefication
//
//  Created by David Tjokroaminoto on 13/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import "MemeShareViewController.h"

@interface MemeShareViewController ()

@property (strong, nonatomic) UIImage *tempImage;
@property BOOL isSavedToPhotos;

@end

@implementation MemeShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    _memeImage.image = _tempImage;
    [self runAds];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRenderedImage:(UIImage *)image {
    _tempImage = image;
}

- (void)prepareUI {
    _saveButton = [MemeHelper addRadius:_saveButton color:nil];
    _doneButton = [MemeHelper addRadius:_doneButton color:nil];
    _shareButton = [MemeHelper addRadius:_shareButton color:[MemeHelper getColor:@"red"]];
}

- (void)doneAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

- (IBAction)saveAction:(id)sender {
    if (!_isSavedToPhotos) {
        UIImageWriteToSavedPhotosAlbum(_memeImage.image, nil, nil, nil);
        [KVNProgress showSuccessWithStatus:@"Saved to photos"];
        _isSavedToPhotos = true;
        _saveButton.enabled = false;
        UIColor *grey = [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:0.5 ];
        [_saveButton setTitleColor:grey forState:UIControlStateNormal];
        _saveButton.layer.borderColor = [grey CGColor];
        
    }
}

- (IBAction)socialShareAction:(id)sender {
    NSString *tempImagePath = [NSTemporaryDirectory() stringByAppendingString:@"image.jpg"];
    NSData *imageData = UIImageJPEGRepresentation(_memeImage.image, 100);
    
    [imageData writeToFile:tempImagePath atomically:true];
    NSURL *imageURL = [NSURL fileURLWithPath:tempImagePath];
    
    _docController = [UIDocumentInteractionController interactionControllerWithURL:imageURL];
    _docController.delegate = self;
    _docController.annotation = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"This is the users caption that will be displayed in Instagram"], @"InstagramCaption", nil];
    _docController.UTI = @"com.instagram.exclusivegram";
    [_docController presentOpenInMenuFromRect:CGRectMake(1, 1, 1, 1) inView:self.view animated:YES];
}

- (void)runAds {
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
//    self.bannerView.adUnitID = @"ca-app-pub-1696149948739760/6150731937";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
