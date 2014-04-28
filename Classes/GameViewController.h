//
//  GameViewController.h
//  GreekLetters
//
//  Created by Andy Lee on 3/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QAlphabet;

@interface GameViewController : UIViewController
{
@private
    QAlphabet *_alphabet;
}

//-------------------------------------------------------------------------
// Action methods
//-------------------------------------------------------------------------

- (IBAction)startGame:(id)sender;

- (IBAction)stopGame:(id)sender;

@end
