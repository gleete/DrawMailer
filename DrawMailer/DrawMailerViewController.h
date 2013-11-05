//
//  DrawMailerViewController.h
//  DrawMailer
//
//  Created by Gordon Leete on 11/5/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface DrawMailerViewController : UIViewController

@property (nonatomic,strong) IBOutlet CustomView *customView;
-(IBAction)sharePicture;
-(IBAction)cls;
@end
