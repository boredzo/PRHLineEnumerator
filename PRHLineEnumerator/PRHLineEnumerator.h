/*PRHLineEnumerator.h
 *
 *Created by Peter Hosey on 2004-11-15.
 *Copyright 2004-2008 Peter Hosey. All rights reserved.
 */

#include <stdbool.h>
#import <Foundation/Foundation.h>

//Bugs: only works with \n, not \r, \f, or Unicode's LINE SEPARATOR and PATH_SEPARATOR.

@interface PRHLineEnumerator: NSEnumerator

+ enumeratorWithString:(NSString *)string;
+ newWithString:(NSString *)string;
- initWithString:(NSString *)string;

//Default: YES.
@property bool includesNewlines;

//Returns the first line, or nil.
- (NSString *)nextObject;

//Returns the line number of the last line read: if no lines have been read (-nextObject has never been called), 0U; else, >= 1U.
@property(readonly) NSUInteger lineNumber;

@end

@interface NSString(PRHLineEnumerator)

//Always returns a new enumerator.
- (PRHLineEnumerator *)lineEnumerator;

@end
