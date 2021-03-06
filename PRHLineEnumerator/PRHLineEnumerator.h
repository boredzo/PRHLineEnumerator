/*PRHLineEnumerator.h
 *
 *Created by Peter Hosey on 2004-11-15.
 *Copyright 2004-2008 Peter Hosey. All rights reserved.
 */

#include <stdbool.h>
#import <Foundation/Foundation.h>

@interface PRHLineEnumerator: NSEnumerator

+ (instancetype) enumeratorWithString:(NSString *)string;
+ (instancetype) newWithString:(NSString *)string;
- (instancetype) initWithString:(NSString *)string;

- (instancetype) initWithFileURL:(NSURL *)URL error:(out NSError **)outError;

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
