//
//  TileView.m
//  GreekLetters
//
//  Created by Andy Lee on 3/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TileView.h"

#import "QLetter.h"

@implementation TileView

//-------------------------------------------------------------------------
// Init/awake/dealloc
//-------------------------------------------------------------------------

- (id)initWithLetter:(QLetter *)letter
{
    NSLog(@"-[TileView initWithLetter:]");
    CGRect frame = CGRectMake(0, 0, 50, 50);
    if ((self = [self initWithFrame:frame])) {
        _letter = [letter retain];
        self.opaque = NO;

        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.userInteractionEnabled = NO;
        button.frame = self.bounds;
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [button setTitle:[letter letterString] forState:UIControlStateNormal];
        [self addSubview:button];
    }

    return self;
}

- (void)dealloc
{
    NSLog(@"-[TileView dealloc]");
    [_letter release], _letter = nil;

    [super dealloc];
}

//-------------------------------------------------------------------------
// Accessors
//-------------------------------------------------------------------------

@synthesize letter = _letter;

@end
