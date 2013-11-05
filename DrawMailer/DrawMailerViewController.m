//
//  DrawMailerViewController.m
//  DrawMailer
//
//  Created by Gordon Leete on 11/5/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//

#import "DrawMailerViewController.h"

@interface DrawMailerViewController ()

@end

@implementation DrawMailerViewController
@synthesize customView;

-(IBAction)sharePicture{
    UIImage *image = [self.customView createImageFromContext];
    NSString *message = @"Here is a great drawing!";
    NSArray *postItems = @[message, image];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(IBAction)cls {
    NSLog(@"CLEAR SCREEN!");
    [self.customView cls];
}
/*
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
@end
