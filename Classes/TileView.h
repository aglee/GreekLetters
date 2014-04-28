//
//  TileView.h
//  GreekLetters
//
//  Created by Andy Lee on 3/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QLetter;

@interface TileView : UIView
{
@private
    QLetter *_letter;
}

@property (nonatomic, readonly) QLetter *letter;

//-------------------------------------------------------------------------
// Init/awake/dealloc
//-------------------------------------------------------------------------

- (id)initWithLetter:(QLetter *)letter;

@end
