//
//  FinishWelcomeViewController.m
//  streaming_platform
//
//  Created by Alexis Porras on 25/02/21.
//

#import "FinishWelcomeViewController.h"
#import "APKernel.h"

@interface FinishWelcomeViewController ()

@end

@implementation FinishWelcomeViewController


- (IBAction)dismisController:(id)sender {
    [[APKernel sharedInstance] setDoneWelcome:YES];
}
@end

