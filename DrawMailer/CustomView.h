//
//  CustomView.h
//  DrawMailer
//
//  Created by Gordon Leete on 11/5/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property(nonatomic,strong)NSMutableArray *layers;
@property(nonatomic,assign)int layerIndex;

-(UIImage *)createImageFromContext;
-(void)cls;


@end
