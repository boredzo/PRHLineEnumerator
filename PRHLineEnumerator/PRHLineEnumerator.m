/*PRHLineEnumerator.m
 *
 *Created by Peter Hosey on 2004-11-15.
 *Copyright 2004-2008 Peter Hosey. All rights reserved.
 */

#import "PRHLineEnumerator.h"

static NSString *newline = @"\n";

@implementation PRHLineEnumerator
{
	NSScanner *_scanner;
}

+ (instancetype) enumeratorWithString:(NSString *)theString {
	return [[self newWithString:theString] autorelease];
}
+ (instancetype) newWithString:(NSString *)theString {
	return [[self alloc] initWithString:theString];
}
- (instancetype) initWithString:(NSString *)theString {
	self = [super init];
	if(self) {
		_scanner = [[NSScanner alloc] initWithString:theString];
	}
	return self;
}

- (NSString *)nextObject {
	NSString *string = nil, *newlineString = nil;
	bool scanUpToSucceeded, scanPastSucceeded;
	scanUpToSucceeded = [_scanner scanUpToString:newline intoString:&string];
	scanPastSucceeded =  [_scanner scanString:newline intoString:&newlineString];

	if(self.includesNewlines && scanPastSucceeded)
		string = [string stringByAppendingString:newlineString];

	[self willChangeValueForKey:@"lineNumber"];
	++_lineNumber;
	[self didChangeValueForKey:@"lineNumber"];

	return string;
}

@end

@implementation NSString(PRHLineEnumerator)

- (PRHLineEnumerator *)lineEnumerator {
	return [PRHLineEnumerator enumeratorWithString:self];
}

@end
