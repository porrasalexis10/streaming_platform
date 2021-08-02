//
//  MainMenuViewController.m
//  streaming_platform
//
//  Created by Alexis Porras on 25/02/21.
//

#import "MainMenuViewController.h"
#import "APKernel.h"


@interface MainMenuViewController ()
{
    AppMode _appMode;
    
}
@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
            
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [story instantiateInitialViewController];
    [self.view.window setRootViewController: viewController];
    
    [self reloadRootViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIStoryboard *storyboard;;

    if (_appMode == AppModeUndefined){
        if(![APKernel sharedInstance].welcomeDone)
            storyboard = [UIStoryboard storyboardWithName:@"Welcome" bundle:nil];
        else
            storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];

        if(storyboard){
            UIViewController *navigationController = [storyboard instantiateInitialViewController];
            navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:navigationController animated:YES completion:nil];
        }
    }
}
- (void)reloadRootViewController
{

}
@end

