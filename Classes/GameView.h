//
//  GameView.h
//  GreekLetters
//
//  Created by Andy Lee on 3/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TileView;

@interface GameView : UIView
{
@private
    CGSize _tileSize;
    CGFloat _tileSpacing;
    NSMutableArray *_tileViews;  // Subviews that are TileViews.

    NSUInteger _indexOfTileBeingDragged;  // An index within _tileViews, or NSNotFound if a tile isn't being dragged.
    NSMutableArray *_tileFrames;  // Used to remember where tiles should go as we shuffle them around while a tile is being dragged.
    CGPoint _previousTouchPoint;  // Used while a tile is being dragged.

    IBOutlet UIButton *_startGameButton;
    IBOutlet UIButton *_stopGameButton;
    IBOutlet UILabel *_messageLabel;
}

//-------------------------------------------------------------------------
// Game management
//-------------------------------------------------------------------------

- (void)startGameWithLetters:(NSArray *)letters;

- (void)stopGame;

- (NSArray *)arrangedLetters;

- (void)showMessage:(NSString *)message;

@end
