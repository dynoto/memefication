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

static NSString * const reuseIdentifier = @"MemeCell";

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
    super.imageList = [MemeHelper getMemeLikedList:nil];
    [super.collectionView reloadData];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length]) {
        super.imageList = [MemeHelper getMemeLikedList:searchText];
    } else {
        super.imageList = [MemeHelper getMemeLikedList:nil];
    }
    [super.collectionView reloadData];
    [searchBar becomeFirstResponder];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSArray *imageObj = [super.imageList objectAtIndex:indexPath.row];
    
    
    [cell setAttributes:[imageObj valueForKey:@"identifier"] imageName:[imageObj valueForKey:@"image_name"]];
    [cell setLabelText:[[imageObj valueForKey:@"name"] uppercaseString]];
    [cell setActive];
    
    // Configure the cell
    
    return cell;
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
