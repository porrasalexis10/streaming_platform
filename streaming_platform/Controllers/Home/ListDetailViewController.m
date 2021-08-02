//
//  ListDetailViewController.m
//  streaming_platform
//
//  Created by Alexis Porras on 01/08/21.
//

@import AVKit;
@import AVFoundation;

#import "ListDetailViewController.h"
#import "TableViewCell.h"

@interface ListDetailViewController (){
    NSPredicate *basePredicate, *filterPredicate;
    NSArray *seasonsArray;
    NSString *selectedSeason;
}

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc]
                                   initWithTitle:nil
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem = dismissButton;
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"close"];
    
    
    [self fetchChapters];
    [self loadDefaults];
    [self loadUI];
}

- (void)fetchChapters{
    NSPredicate *predicate;
    self->basePredicate = [NSPredicate predicateWithFormat:@"enabled == %i && movie_id == %@", YES, self.parenData.db_id];
    
    if (self->filterPredicate)
        predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[self->basePredicate,self->filterPredicate]];
    else
        predicate = self->basePredicate;
    
    self.fetchedResults = [[APCDDataAccess sharedInstance] fetchedResults:@"Chapter" withPredicate:predicate sortedBy:@"episode"];
    self.fetchedResults.delegate = self;
    
    
    [self loadUITable];
}

-(void)loadDefaults{
    if([[self.fetchedResults fetchedObjects] count] > 0){
        self->selectedSeason = @"1";
        self->filterPredicate = [NSPredicate predicateWithFormat:@"season = %@", self->selectedSeason];
        [self fetchChapters];
    }
    
    if([self.parenData.title  isEqual: @"Hey Paula"]){
        self->seasonsArray = @[@{@"id":@"1", @"title":@"Season 1"}];
    }else{
        self->seasonsArray = @[@{@"id":@"1", @"title":@"Season 1"}, @{@"id":@"2", @"title":@"Season 2"}];
    }
}

-(void)loadUI{
    self.titleLabel.text = self.parenData.title;
    self.extraDataLabel.text = [NSString stringWithFormat:@"%@ - %@",self.parenData.year, self.parenData.rated];
    self.summaryLabel.text = self.parenData.plot;
    self.actorsLabel.text = [NSString stringWithFormat:@"Actors: %@",self.parenData.actors];
    self.createdLabel.text = [NSString stringWithFormat:@"Created by: %@",self.parenData.writer];
    [self.posterImage setImage:[self getPosterImage:self.parenData.poster]];
    
    if(self.parenData.is_favorite){
        [self.favoriteButton setTitle:@"Unfavorite" forState:UIControlStateNormal];
    }else{
        [self.favoriteButton setTitle:@"Favorite" forState:UIControlStateNormal];
    }
}

-(void)loadUITable{

    if([[self.fetchedResults fetchedObjects] count] > 0){
        [self.tableView reloadData];
        [self.tableView setHidden:NO];
        
        [self.seasonButton setHidden:NO];
        self.heightTableConstraint.constant = [[self.fetchedResults fetchedObjects] count] * 190;
    }else{
        [self.seasonButton setHidden:YES];
        self.heightTableConstraint.constant = 0;
    }
}

#pragma mark - Table view data source
- (UITableViewCell *)configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if(!cell)
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Chapter *row = [self.fetchedResults objectAtIndexPath:indexPath];
    
    cell.parentController = self;
    
    cell.titleLabel.text = row.title;
    cell.runtimeLabel.text = row.runtime;
    cell.summaryLabel.text = row.plot;
    
    [cell.posterImage setImage:[self getPosterImage:row.poster]];
    
    return cell;
}


#pragma mark - Button actions
- (IBAction)playVideo:(id)sender {
    [self reproduceVideo];
}

- (IBAction)showSeasons:(id)sender{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
   for(NSDictionary *row in self->seasonsArray){
       [actionSheet addAction:[UIAlertAction actionWithTitle:row[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
           self->selectedSeason = row[@"id"];
           [self.seasonButton setTitle:row[@"title"] forState:UIControlStateNormal];
           self->filterPredicate = [NSPredicate predicateWithFormat:@"season == %@", self->selectedSeason];
           [self fetchChapters];
       }]];
   }
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)setFavorite:(id)sender {
    if(self.parenData.is_favorite){
        [self.favoriteButton setTitle:@"Favorite" forState:UIControlStateNormal];
        self.parenData.is_favorite = NO;
    }else{
        [self.favoriteButton setTitle:@"Unfavorite" forState:UIControlStateNormal];
        self.parenData.is_favorite = YES;
    }
    
    [[APCDDataAccess sharedInstance] saveContext];
}

- (IBAction)shareMovie:(id)sender {
    NSString *movieTitle = [NSString stringWithFormat:@"¿Ya viste '%@' en Blue Parrot Sreaming?",self.parenData.title];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[movieTitle, [NSURL URLWithString:@"https://www.youtube.com/watch?v=C9qxnGlS3PQ"]] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

#pragma mark - Generic fuctions
- (UIImage *)getPosterImage:(NSString *)url{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    
    if(imageData){
        return [UIImage imageWithData: imageData];
    }else{
        return [UIImage imageNamed:@"empty_movie"];
    }
}

- (void) reproduceVideo{
    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=C9qxnGlS3PQ"];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    
    controller.view.frame = CGRectMake(0,50,self.view.frame.size.width,220);
    controller.player = player;
    controller.showsPlaybackControls = YES;
    player.closedCaptionDisplayEnabled = NO;
    [player pause];
    [player play];
}

- (void)dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
