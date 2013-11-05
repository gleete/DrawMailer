//
//  CustomView.m
//  DrawMailer
//
//  Created by Gordon Leete on 11/5/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//

#import "CustomView.h"
#include <QuartzCore/QuartzCore.h>


@implementation CustomView

@synthesize layers,layerIndex;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        NSLog(@"InitWithFram - will I ever get called??");
    }
    return self;
}

-(NSMutableArray *)layers {
    if(layers == nil) layers = [[NSMutableArray alloc] init];
    return layers;
}


-(UIImage *)createImageFromContext {
    NSLog(@"createImagefromContext - dump view contents to image");
    
    CGRect contextRect = CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height);
    
    UIGraphicsBeginImageContext(contextRect.size);
    
    //get whatever the user drew in the view
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //create a new image with it
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return theImage; //nil to get rid of warning
}

-(void)cls {
    NSLog(@"cls - clear the screen");
    // our next layer starts at zero again
	self.layerIndex = 0;
	
	// loop through array and get rid of all the points in each 	// array
	for (NSMutableArray *points in self.layers) {
		[points removeAllObjects];
	}
	
	// get rid of all of the empty layer arrays
	[self.layers removeAllObjects];
	
	// update view
	[self setNeedsDisplay];

}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSLog(@"drawRect - I get called when the view is 'dirty'");
    
    //Get pointer to view
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    //loop through our layers (if any)
    for (NSMutableArray *points in self.layers){
        //the "pen" color is white - change this if you want
        [[UIColor whiteColor] set];
        //set the line width to 3
        CGContextSetLineWidth(context, 3.0f);
        //loop through each layer's point values
        for (int i = 0; i < [points count] - 1; i++){
            CGPoint pt1 = [[points objectAtIndex:i] CGPointValue];
            CGPoint pt2 = [[points objectAtIndex:(i+1)] CGPointValue];
            CGContextMoveToPoint(context, pt1.x, pt1.y);
            CGContextAddLineToPoint(context, pt2.x, pt2.y);
            CGContextStrokePath(context);
        }
    }
}

//on New touch, start a new array (layer) of pounts
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray *points = [NSMutableArray array];
    [self.layers addObject:points];
    
    CGPoint pt = [[touches anyObject] locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:pt]];
    NSLog(@"LAyer %d created", self.layerIndex);
}

//Add each point to the correct array as the finger moves
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableArray *points = [self.layers objectAtIndex:self.layerIndex];
    
    CGPoint pt = [[touches anyObject] locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:pt]];
    
    [self setNeedsDisplay];
    //NSLog(@"point added");
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSMutableArray *points = [self.layers objectAtIndex:self.layerIndex];
    
    NSLog(@"layer %d now has %d points", self.layerIndex, [points count]);
    
    self.layerIndex ++;
    
    [self setNeedsDisplay];
}



@end
