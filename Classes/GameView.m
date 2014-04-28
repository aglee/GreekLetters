//
//  GameView.m
//  GreekLetters
//
//  Created by Andy Lee on 3/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"

#import "TileView.h"
#import "QLetter.h"

//-------------------------------------------------------------------------
// Forward declarations of private methods
//-------------------------------------------------------------------------

@interface GameView ()
- (void)_initIvars;
- (void)_removeAllTileViews;
- (void)_layoutTilesHorizontally;
- (void)_layoutTilesVertically;
- (NSUInteger)_indexOfTileUnderPoint:(CGPoint)touchPoint;
- (void)_tileDragDidEnd;
@end


@implementation GameView

//-------------------------------------------------------------------------
// Init/awake/dealloc
//-------------------------------------------------------------------------

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self _initIvars];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if ((self = [super initWithCoder:coder]))
    {
        [self _initIvars];
    }

    return self;
}

- (void)awakeFromNib
{
    [_messageLabel setHidden:NO];
    [_startGameButton setEnabled:YES];
    [_stopGameButton setEnabled:NO];
}

- (void)dealloc
{
    [_tileViews release], _tileViews = nil;
    [_tileFrames release], _tileFrames = nil;

    [super dealloc];
}

//-------------------------------------------------------------------------
// Game management
//-------------------------------------------------------------------------

- (void)startGameWithLetters:(NSArray *)letters
{
    // Enable and disable controls to reflect our new state.
    [_messageLabel setHidden:YES];
    [_startGameButton setEnabled:NO];
    [_stopGameButton setEnabled:YES];

    // Update tiles.
    [self _removeAllTileViews];
    for (QLetter *letter in letters)
    {
        TileView *tileView = [[TileView alloc] initWithLetter:letter];
        [_tileViews addObject:tileView];
        [self addSubview:tileView];
        [tileView release];
    }
    [self setNeedsLayout];
}

- (void)stopGame
{
    // Enable and disable controls to reflect our new state.
    [_messageLabel setHidden:NO];
    [_startGameButton setEnabled:YES];
    [_stopGameButton setEnabled:NO];

    // Update tiles.
    [self _removeAllTileViews];
}

- (void)showMessage:(NSString *)message
{
    [_messageLabel setText:message];
}

//-------------------------------------------------------------------------
// UIView methods
//-------------------------------------------------------------------------

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews");

    if (_indexOfTileBeingDragged != NSNotFound)
    {
        return;
    }

    if (self.bounds.size.width < self.bounds.size.height)
    {
        [self _layoutTilesVertically];
    }
    else if (self.bounds.size.width > self.bounds.size.height)
    {
        [self _layoutTilesHorizontally];
    }
}

- (NSArray *)arrangedLetters
{
    NSMutableArray *result = [NSMutableArray array];

    for (TileView *tileView in _tileViews)
    {
        NSLog(@"[%@]", tileView.letter.letterString);
        [result addObject:tileView.letter];
    }

    return result;
}

//-------------------------------------------------------------------------
// UIResponder methods
//-------------------------------------------------------------------------

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];

    // If a tile is being dragged, make it the frontmost view.
    _indexOfTileBeingDragged = [_tileViews indexOfObjectIdenticalTo:[touch view]];
    if (_indexOfTileBeingDragged != NSNotFound)
    {
        _previousTouchPoint = [touch locationInView:self];
        [self bringSubviewToFront:[touch view]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_indexOfTileBeingDragged != NSNotFound)
    {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        UIView *tileBeingDragged = [_tileViews objectAtIndex:_indexOfTileBeingDragged];

        // Update the position of the tile being dragged.
        CGFloat deltaX = touchPoint.x - _previousTouchPoint.x;
        CGFloat deltaY = touchPoint.y - _previousTouchPoint.y;
        CGRect frame = tileBeingDragged.frame;
        frame.origin.x += deltaX;
        frame.origin.y += deltaY;
        tileBeingDragged.frame = frame;
        _previousTouchPoint = touchPoint;

        // If the touch point is inside the frame of any tile other than the one being dragged, shuffle the tiles around.
        NSUInteger touchedTileIndex = [self _indexOfTileUnderPoint:touchPoint];
        if (touchedTileIndex != NSNotFound && touchedTileIndex != _indexOfTileBeingDragged)
        {
            // Move tileBeingDragged to its new position within _tileViews.
            [tileBeingDragged retain];
            [_tileViews removeObject:tileBeingDragged];
            [_tileViews insertObject:tileBeingDragged atIndex:touchedTileIndex];
            [tileBeingDragged release];
            _indexOfTileBeingDragged = touchedTileIndex;

            // Update the frames of all tiles except the one being dragged.
            for (NSUInteger i = 0; i < [_tileViews count]; i++)
            {
                if (i != _indexOfTileBeingDragged)
                {
                    CGRect newFrame = [[_tileFrames objectAtIndex:i] CGRectValue];
                    UIView *tileView = [_tileViews objectAtIndex:i];
                    tileView.frame = newFrame;
                }
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _tileDragDidEnd];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _tileDragDidEnd];
}

//-------------------------------------------------------------------------
// Private methods
//-------------------------------------------------------------------------

/*! Called during object initialization. */
- (void)_initIvars
{
    _tileSize = CGSizeMake(80, 40);
    _tileSpacing = 8;
    _tileViews = [[NSMutableArray alloc] init];
    _indexOfTileBeingDragged = NSNotFound;
    _tileFrames = [[NSMutableArray alloc] init];
}

- (void)_removeAllTileViews
{
    for (UIView *tileView in _tileViews)
    {
        [tileView removeFromSuperview];
    }

    [_tileViews removeAllObjects];
}

/*! Lay the tiles in a horizontal row, left to right, separated by _tileSpacing. */
- (void)_layoutTilesHorizontally
{
    // Figure out what the total width of the lined-up tiles will be.
    int numTiles = [_tileViews count];
    CGFloat totalWidth = numTiles*_tileSize.width + (numTiles - 1)*_tileSpacing;

    // Position the tiles one by one.
    [_tileFrames removeAllObjects];
    CGRect tileFrame;
    tileFrame.size = _tileSize;
    CGFloat centerX = self.bounds.origin.x + self.bounds.size.width/2;
    CGFloat tileCenterY = self.bounds.origin.y + self.bounds.size.height/3;
    tileFrame.origin.x = centerX - totalWidth/2;
    tileFrame.origin.y = tileCenterY - _tileSize.height/2;
    for (UIView *tileView in _tileViews)
    {
        tileView.frame = tileFrame;
        [_tileFrames addObject:[NSValue valueWithCGRect:tileFrame]];

        tileFrame.origin.x += _tileSize.width + _tileSpacing;
    }
}

/*! Lay the tiles in a vertical column, top to bottom, separated by _tileSpacing. */
- (void)_layoutTilesVertically
{
    // Figure out what the total height of the lined-up tiles will be.
    int numTiles = [_tileViews count];
    CGFloat totalHeight = numTiles*_tileSize.height + (numTiles - 1)*_tileSpacing;

    // Position the tiles one by one.
    [_tileFrames removeAllObjects];
    CGRect tileFrame;
    tileFrame.size = _tileSize;
    tileFrame.origin.x = self.center.x - _tileSize.width/2;
    tileFrame.origin.y = self.center.y - totalHeight/2;
    for (UIView *tileView in _tileViews)
    {
        tileView.frame = tileFrame;
        [_tileFrames addObject:[NSValue valueWithCGRect:tileFrame]];

        tileFrame.origin.y += _tileSize.height + _tileSpacing;
    }
}

- (NSUInteger)_indexOfTileUnderPoint:(CGPoint)touchPoint
{
    for (NSUInteger i = 0; i < [_tileFrames count]; i++)
    {
        if (CGRectContainsPoint([[_tileFrames objectAtIndex:i] CGRectValue], touchPoint))
        {
            return i;
        }
    }

    // If we got this far, the point isn't in any of the tile rects.
    return NSNotFound;
}

- (void)_tileDragDidEnd
{
    if (_indexOfTileBeingDragged != NSNotFound)
    {
        // Send the tile that was being dragged to its home spot.
        UIView *tileBeingDragged = [_tileViews objectAtIndex:_indexOfTileBeingDragged];
        CGRect tileFrame = [[_tileFrames objectAtIndex:_indexOfTileBeingDragged] CGRectValue];
        tileBeingDragged.frame = tileFrame;
        _indexOfTileBeingDragged = NSNotFound;
    }
}

@end
