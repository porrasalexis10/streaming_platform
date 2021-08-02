//
//  FavoritesViewController.m
//  streaming_platform
//
//  Created by Alexis Porras on 01/08/21.
//

#import "FavoritesViewController.h"
#import "ListDetailViewController.h"
//Cell
#import "CollectionViewCell.h"

@interface FavoritesViewController (){
    UIRefreshControl *refreshControl;
    CGSize _targetCellSize;
    
    NSPredicate *basePredicate, *filterPredicate;
    Movie *selectedMovie;
}

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self->refreshControl = [[UIRefreshControl alloc]init];
    self->refreshControl.tintColor = [UIColor whiteColor];
    [self->refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    
    if (@available(iOS 10.0, *)) {
        self.collectionView.refreshControl = self->refreshControl;
    } else {
        [self.collectionView addSubview:self->refreshControl];
    }
    
    [self fetchMovies];
}

- (void)fetchMovies{
    [self->refreshControl beginRefreshing];
    
    NSPredicate *predicate;
    self->basePredicate = [NSPredicate predicateWithFormat:@"enabled = %i AND is_favorite = %i", YES, YES];
    
    if (self->filterPredicate)
        predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[self->basePredicate,self->filterPredicate]];
    else
        predicate = self->basePredicate;
    
    self.fetchedResults = [[APCDDataAccess sharedInstance] fetchedResults:@"Movie" withPredicate:predicate sortedBy:@"title"];
    self.fetchedResults.delegate = self;
    
    [self loadUI];
}

-(void)loadUI{

    if([[self.fetchedResults fetchedObjects] count] > 0){
        [self.collectionView reloadData];
        [self.collectionView setHidden:NO];
        [self.emptyView setHidden:YES];
    }else{
        [self.collectionView setHidden:YES];
        [self.emptyView setHidden:NO];
    }

    [self->refreshControl endRefreshing];
    
}

#pragma mark - CollectionView
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat targetSizeH = self.view.frame.size.width / 2.0 + 40.0;
    CGFloat targetSizeW = self.view.frame.size.width / 2.0 - 30.0;
    _targetCellSize = CGSizeMake(targetSizeW, targetSizeH);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return _targetCellSize;
}

- (UICollectionViewCell *)configureCell:(CollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (!cell)
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Movie *row = [self.fetchedResults objectAtIndexPath:indexPath];
    cell.titleLabel.text = row.title;

    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: row.poster]];
    if(imageData)
        [cell.posterImage setImage:[UIImage imageWithData: imageData]];
    else
        [cell.posterImage setImage:[UIImage imageNamed:@"empty_movie"]];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    Movie *row = [self.fetchedResults objectAtIndexPath:indexPath];
    self->selectedMovie = row;
    [self performSegueWithIdentifier:@"showDetailSegue" sender:nil];
}

#pragma mark - Filters
- (IBAction)selectTypeAll:(id)sender {
    [self.allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.serieButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.movieButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self->filterPredicate = nil;
    [self fetchMovies];
}

- (IBAction)selectTypeSerie:(id)sender {
    [self.allButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.serieButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.movieButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self->filterPredicate = [NSPredicate predicateWithFormat:@"type = %@", @"series"];
    [self fetchMovies];
}

- (IBAction)selectTypeMovie:(id)sender {
    [self.allButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.serieButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.movieButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self->filterPredicate = [NSPredicate predicateWithFormat:@"type = %@", @"movie"];
    [self fetchMovies];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        ListDetailViewController *navigationController = [[(UINavigationController *)[segue destinationViewController] viewControllers] lastObject];
        navigationController.parenData = self->selectedMovie;
        navigationController.parentController = self;
    }
}

@end
