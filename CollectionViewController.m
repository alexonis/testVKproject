//
//  CollectionViewController.m
//  testVKproject
//
//  Created by Alexonis on 29.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
@interface CollectionViewController ()

@end

@implementation CollectionViewController
bool isRefresh;
NSMutableArray *imgs;
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    isRefresh=false;
    [super viewDidLoad];
    self.title=self.userI.fullName;
    [self.userI getUserImages:0];
    imgs=[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadImgComplete)
                                                 name:@"GetImagesComplete"
                                               object:nil];
}

-(void) downloadImgComplete
{
    [imgs addObjectsFromArray:self.userI.imagesUser_urls];
    [self.collectionView reloadData];
    if ([imgs count]==self.userI.valueImages) {
        [self.collectionView reloadData];
        isRefresh=false;
    }
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
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imgs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    // Configure the cell
    cell.imgsUsr.image=[UIImage imageNamed:@"notavatar.jpeg"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // Загрузка в другом потоке
        UIImage *img=[self.userI imgDownload:imgs[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{ //Показываем фотографию в основном потоке
            cell.imgsUsr.image=img;
        });
    });
    //if ((indexPath.row==[imgs count]/2)&&(indexPath.row + 1<self.userI.colvoImg)&&([imgs count]!=self.userI.colvoImg)) {
       
      //  [self.userI getUserImages:[imgs count]];
    //}

     NSLog(@"%lu %i", (unsigned long)[imgs count], self.userI.valueImages);
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     NSLog(@"%f  %f",scrollView.contentSize.width,scrollView.contentSize.height);
    
     if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height) && !isRefresh)
     {
         isRefresh=true;
         [self.userI getUserImages:[imgs count]];
         NSLog(@" !!!!!!!!");
     }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
