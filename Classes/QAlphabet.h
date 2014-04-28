//
//  Alphabet.h
//  GreekLetters
//
//  Created by Andy Lee on 3/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QLetter;

/*! Defines an alphabetical ordering of letters, as represented by instances of QLetter. */
@interface QAlphabet : NSObject
{
@private
    NSMutableArray *_letters;
}

//-------------------------------------------------------------------------
// Factory methods
//-------------------------------------------------------------------------

+ (id)englishAlphabet;

//-------------------------------------------------------------------------
// Managing letters
//-------------------------------------------------------------------------

- (void)addLetter:(QLetter *)letter;

/*! Returns an array of selectionSize distinct QLetter instances.  If selectionSize is greater than the total number of letters available, returns nil. */
- (NSArray *)randomSelectionOfSize:(NSUInteger)selectionSize;

/*! Return YES if the QLetter instances in letterArray are in alphabetical order. */
- (BOOL)checkOrderOfLetters:(NSArray *)letterArray;

// [COSI]
- (NSUInteger)numberOfLetters;
- (QLetter *)letterAtIndex:(NSUInteger)index;
// [COSI]
@end
