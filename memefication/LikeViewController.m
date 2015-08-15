//
//  LikeViewController.m
//  memefication
//
//  Created by David Tjokroaminoto on 15/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import "LikeViewController.h"

@interface LikeViewController ()

@end

@implementation LikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    super.imageList = [MemeHelper getMemeLikedList:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"Test");
    super.imageList = [MemeHelper getMemeLikedList:nil];
    [super.collectionView reloadData];
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
