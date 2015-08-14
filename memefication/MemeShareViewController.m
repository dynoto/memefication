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

@end

@implementation MemeShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    _memeImage.image = _tempImage;
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
    _memeImage.layer.borderWidth = 2.0f;
    _memeImage.layer.borderColor = [MemeHelper getColor:@"red"];
    
    _doneButton = [MemeHelper addButtonRadius:_doneButton color:nil];
    _shareButton = [MemeHelper addButtonRadius:_shareButton color:[MemeHelper getColor:@"red"]];
    
    
}

- (void)doneAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:TRUE];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
