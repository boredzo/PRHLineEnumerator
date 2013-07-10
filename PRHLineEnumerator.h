/*PRHLineEnumerator.h
 *
 *Created by Peter Hosey on 2004-11-15.
 *Copyright 2004-2008 Peter Hosey. All rights reserved.
 */

#import <Cocoa/Cocoa.h>

//Bugs: only works with \n, not \r, \f, or Unicode's LINE SEPARATOR and PATH_SEPARATOR.

@interface PRHLineEnumerator: NSEnumerator
{
//	NSString *string;
	NSScanner *scanner;
	unsigned lineNumber;

	unsigned reserved: 31;
	unsigned includesNewlines: 1;
}

+ enumeratorWithString:(NSString *)string;
+ newWithString:(NSString *)string;
- initWithString:(NSString *)string;

//Default: YES.
- (BOOL)includesNewlines;
- (void)setIncludesNewlines:(BOOL)flag;

//Returns the first line, or nil.
- (NSString *)nextObject;

//Returns the line number of the last line read: if no lines have been read (-nextObject has never been called), 0U; else, >= 1U.
- (unsigned)lineNumber;

@end

@interface NSString(PRHLineEnumerator)

//Always returns a new enumerator.
- (PRHLineEnumerator *)lineEnumerator;

@end
