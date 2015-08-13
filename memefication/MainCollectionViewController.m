//
//  MainCollectionViewController.m
//  memefication
//
//  Created by David Tjokroaminoto on 11/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import "AppDelegate.h"
#import "MainCollectionViewController.h"
#import "MemeCollectionViewCell.h"
#import "MemeCreateViewController.h"

@interface MainCollectionViewController ()

@property (strong, nonatomic) NSArray *imageList;
@property (strong, nonatomic) UIImage *selectedImage;

@end

@implementation MainCollectionViewController

static NSString * const reuseIdentifier = @"MemeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self saveMemeImage];
    [self getMemeImage];
    [self resizeCollectionView];
    [self addSearchBar];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MemeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return [_imageList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSArray *imageObj = [_imageList objectAtIndex:indexPath.row];
    
    
    [cell setImage: [imageObj valueForKey:@"image_name"]];
    [cell setLabelText:[imageObj valueForKey:@"name"]];

    // Configure the cell
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenSize = [UIScreen mainScreen].applicationFrame;
    return CGSizeMake(screenSize.size.width/2, screenSize.size.width/2 );
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 40);
}

- (void)resizeCollectionView {
    CGRect newPos = self.collectionView.frame;
    newPos.size.height -= 49;
    self.collectionView.frame = newPos;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)addSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.bounds.size.width, 40)];
    self.searchBar.barTintColor = [UIColor whiteColor];
    self.searchBar.delegate = self;
    [self.collectionView addSubview:self.searchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Search for something");
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
//	return YES;
//}

//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//	return YES;
//}

//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MemeCollectionViewCell *vc = [collectionView cellForItemAtIndexPath:indexPath];
    _selectedImage = vc.memeImage.image;
    
    [self performSegueWithIdentifier:@"segueMemeListToCreate" sender:self];
}

#pragma mark CoreData
- (void)getMemeImage {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // MOC is like getting the database, in this case from AppDelegate
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    // Entity description is similar to selecting "table"
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeImage" inManagedObjectContext:moc];
    
    // Create a fetch request, set the entity is like pointing to the database table
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:ed];
    
    // similar to SQL query "where"
    // NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)",@"troll"];
    // [req setPredicate:pred];
    
    _imageList = [moc executeFetchRequest:req error:nil];
}

- (void)saveMemeImage {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // MOC is like getting the database, in this case from AppDelegate
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    // Entity description is similar to selecting "table"
    // NSManagedObject is for "saving" file
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeImage" inManagedObjectContext:moc];
    NSManagedObject *mo = [[NSManagedObject alloc] initWithEntity:ed insertIntoManagedObjectContext:moc];
    
    [mo setValue:@"Confession Bear" forKey:@"name"];
    [mo setValue:@"confession-bear" forKey:@"image_name"];
    [moc save:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController respondsToSelector:@selector(setImageName:)]) {
        [segue.destinationViewController performSelector:@selector(setImageName:) withObject:_selectedImage];
    }
}

@end
