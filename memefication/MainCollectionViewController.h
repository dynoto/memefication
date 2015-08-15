//
//  MainCollectionViewController.h
//  memefication
//
//  Created by David Tjokroaminoto on 11/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemeCollectionViewCell.h"
#import "MemeCreateViewController.h"
#import "MemeHelper.h"

@interface MainCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionReusableView *collectionViewHeader;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *imageList;
@property (strong, nonatomic) UIImage *selectedImage;



@end
