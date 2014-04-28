//
//  Alphabet.m
//  GreekLetters
//
//  Created by Andy Lee on 3/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "QAlphabet.h"

#import "QLetter.h"

@implementation QAlphabet

//-------------------------------------------------------------------------
// Factory methods
//-------------------------------------------------------------------------

+ (id)englishAlphabet
{
    QAlphabet *alphabet = [[[[self class] alloc] init] autorelease];
    char *letterChars = "abcdefghijklmnopqrstuvwxyz";
    int numLetters = strlen(letterChars);

    for (int i = 0; i < numLetters; i++) {
        NSString *letterString = [NSString stringWithFormat:@"%c", letterChars[i]];
        QLetter *letter = [[QLetter alloc] initWithString:letterString pronunciation:letterString uppercase:NO];
        [alphabet addLetter:letter];
        [letter release];
    }

    return alphabet;
}

//-------------------------------------------------------------------------
// Init/awake/dealloc
//-------------------------------------------------------------------------

- (id)init
{
    if ((self = [super init])) {
        _letters = [[NSMutableArray alloc] init];
    }

    return self;
}

- (void)dealloc
{
    [_letters release], _letters = nil;

    [super dealloc];
}

//-------------------------------------------------------------------------
// Managing letters
//-------------------------------------------------------------------------

- (void)addLetter:(QLetter *)letter
{
    [_letters addObject:letter];
}

- (NSArray *)randomSelectionOfSize:(NSUInteger)selectionSize
{
    if (selectionSize > [_letters count]) {
        return nil;
    }

    NSMutableArray *letterPool = [NSMutableArray arrayWithArray:_letters];
    NSMutableArray *result = [NSMutableArray array];

    for (NSUInteger i = 0; i < selectionSize; i++) {
        NSUInteger letterIndex = rand() % [letterPool count];
        QLetter *letter = [letterPool objectAtIndex:letterIndex];
        [letterPool removeObjectAtIndex:letterIndex];
        [result addObject:letter];
    }

    return result;
}

- (BOOL)checkOrderOfLetters:(NSArray *)letterArray
{
    int previousLetterIndex = -1;
    for (QLetter *letter in letterArray) {
        int letterIndex = [_letters indexOfObject:letter];
        NSLog(@"previousLetterIndex: %d, letterIndex: %d", previousLetterIndex, letterIndex);
        if (letterIndex <= previousLetterIndex) {
            NSLog(@"returning NO");
            return NO;
        }
        previousLetterIndex = letterIndex;
    }

    // If we got this far, the array is in perfect alphabetical order.
    return YES;
}

// [COSI]
- (NSUInteger)numberOfLetters
{
    return [_letters count];
}

- (QLetter *)letterAtIndex:(NSUInteger)index
{
    return [_letters objectAtIndex:index];
}
// [COSI]
@end
