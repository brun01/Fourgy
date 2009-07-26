//
//  DTBlockScrollerView.m
//  iPod
//
//  Created by Daniel Tull on 26.07.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTBlockScroller.h"


@implementation DTBlockScroller

@synthesize numberOfitems, numberOfItemsOnScreen, currentItemNumber, knobInsets, scrollerInsets;

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
	
	scrollerInsets = UIEdgeInsetsMake(0, 0, 0, 0);
	knobInsets = UIEdgeInsetsMake(0, 0, 0, 0);
	numberOfitems = 1;
	numberOfItemsOnScreen = 1;
	currentItemNumber = 0;
	
    return self;
}


- (void)drawRect:(CGRect)aRect {
	
	CGRect rect = CGRectMake(aRect.origin.x + self.scrollerInsets.left,
							 aRect.origin.y + self.scrollerInsets.top,
							 aRect.size.width - self.scrollerInsets.left - self.scrollerInsets.right,
							 aRect.size.height - self.scrollerInsets.top - self.scrollerInsets.bottom);
	
	[self drawBackgroundInRect:rect];
	
	CGFloat knobHeight = (rect.size.height * numberOfItemsOnScreen / numberOfitems);
	
	NSLog(@"%@:%s knobHeight: %f %f", self, _cmd, knobHeight, rect.size.height);
	
	CGFloat knobPosition = (rect.size.height - knobHeight) * self.currentItemNumber / (self.numberOfitems - 1);
	
	NSLog(@"currentItemNumber = %i, numberOfitems = %i, knobPosition = %f", self.currentItemNumber, self.numberOfitems, knobPosition);
	
	[self drawKnobInRect:CGRectMake(knobInsets.left,
									knobPosition + knobInsets.top, 
									rect.size.width - knobInsets.left - knobInsets.right, 
									knobHeight - knobInsets.top - knobInsets.bottom)];
}

- (void)drawBackgroundInRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetGrayFillColor(context, 0.5, 1.0);
	CGContextFillRect(context, rect);
}

- (void)drawKnobInRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetGrayFillColor(context, 0.0, 1.0);
	CGContextFillRect(context, rect);
}

- (void)setCurrentItemNumber:(NSInteger)anInteger {
	NSLog(@"currentItemNumber = %i, numberOfitems = %i, numberOfItemsOnScreen = %i", anInteger, self.numberOfitems, self.numberOfItemsOnScreen);
	currentItemNumber = anInteger;
	[self setNeedsDisplay];
}


@end