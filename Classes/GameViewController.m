//
//  GameViewController.m
//  GreekLetters
//
//  Created by Andy Lee on 3/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"

#import "QAlphabet.h"
#import "GameView.h"

@implementation GameViewController

//-------------------------------------------------------------------------
// Init/awake/dealloc
//-------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _alphabet = [[QAlphabet englishAlphabet] retain];
    }

    return self;
}

- (void)dealloc
{
    [_alphabet release], _alphabet = nil;

    [super dealloc];
}

//-------------------------------------------------------------------------
// Action methods
//-------------------------------------------------------------------------

- (IBAction)startGame:(id)sender
{
    NSArray *gameLetters = [_alphabet randomSelectionOfSize:4];

    [(GameView *)self.view startGameWithLetters:gameLetters];
}

- (IBAction)stopGame:(id)sender
{
    NSArray *arrangedLetters = [(GameView *)self.view arrangedLetters];
    BOOL isCorrect = [_alphabet checkOrderOfLetters:arrangedLetters];

    NSLog(@"is solution correct? %d", isCorrect);
    [(GameView *)self.view stopGame];
    [(GameView *)self.view showMessage:(isCorrect ? @"You win!" : @"You lose")];
}

//-------------------------------------------------------------------------
// 
//-------------------------------------------------------------------------

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"shouldAutorotateToInterfaceOrientation:");
    return
        (interfaceOrientation == UIDeviceOrientationLandscapeLeft)
        || (interfaceOrientation == UIDeviceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"didRotateFromInterfaceOrientation:");
    [self.view setNeedsLayout];
}

@end
