//
//  QLetter.m
//  GreekLetters
//
//  Created by Andy Lee on 3/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "QLetter.h"

@implementation QLetter

//-------------------------------------------------------------------------
// Init/awake/dealloc
//-------------------------------------------------------------------------

- (id)initWithString:(NSString *)letterString pronunciation:(NSString *)pronunciation uppercase:(BOOL)isUppercase
{
    if ((self = [super init])) {
        _letterString = [letterString retain];
        _pronunciation = [pronunciation retain];
        _isUppercase = isUppercase;
    }

    return self;
}

- (void)dealloc
{
    [_letterString release], _letterString = nil;
    [_pronunciation release], _pronunciation = nil;

    [super dealloc];
}

//-------------------------------------------------------------------------
// Accessors
//-------------------------------------------------------------------------

@synthesize letterString = _letterString;
@synthesize pronunciation = _pronunciation;
@synthesize isUppercase = _isUppercase;

@end
