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
    UIColor *blueColor = [UIColor colorWithRed:19/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
    _memeImage.layer.borderWidth = 0.8f;
    _memeImage.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0] CGColor];
    
    _doneButton.layer.cornerRadius  = 5;
    _doneButton.layer.borderWidth   = 1.0f;
    _doneButton.layer.borderColor   = [blueColor CGColor];
}

- (void)doneAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:TRUE];
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
