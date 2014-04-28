//
//  QLetter.h
//  GreekLetters
//
//  Created by Andy Lee on 3/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLetter : NSObject
{
@private
    NSString *_letterString;
    NSString *_pronunciation;
    BOOL _isUppercase;
}

@property (nonatomic, copy) NSString *letterString;
@property (nonatomic, copy) NSString *pronunciation;
@property (nonatomic, assign) BOOL isUppercase;

- (id)initWithString:(NSString *)letterString pronunciation:(NSString *)pronunciation uppercase:(BOOL)isUppercase;

@end
