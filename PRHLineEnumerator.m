/*PRHLineEnumerator.m
 *
 *Created by Peter Hosey on 2004-11-15.
 *Copyright 2004-2008 Peter Hosey. All rights reserved.
 */

#import "PRHLineEnumerator.h"

static NSString *newline = @"\n";

@implementation PRHLineEnumerator

+ enumeratorWithString:(NSString *)theString {
	return [[self newWithString:theString] autorelease];
}
+ newWithString:(NSString *)theString {
	return [[self alloc] initWithString:theString];
}
- initWithString:(NSString *)theString {
	self = [super init];
	if(self) {
//		string = theString;
		scanner = [[NSScanner alloc] initWithString:theString];
	}
	return self;
}

- (NSString *)nextObject {
//	unsigned loc = [scanner scanLocation];
	NSString *string = nil, *newlineString = nil;
	BOOL scanUpToSucceeded, scanPastSucceeded;
	scanUpToSucceeded = [scanner scanUpToString:newline intoString:&string];
	scanPastSucceeded =  [scanner scanString:newline intoString:&newlineString];

	if(includesNewlines && scanPastSucceeded)
		string = [string stringByAppendingString:newlineString];

	++lineNumber;

//	NSLog(@"%u@%u %u %u \"%@\"", lineNumber, loc, scanUpToSucceeded, scanPastSucceeded, string);
	return string;
}
- (unsigned)lineNumber {
	return lineNumber;
}

@end

@implementation NSString(PRHLineEnumerator)

- (PRHLineEnumerator *)lineEnumerator {
	return [PRHLineEnumerator enumeratorWithString:self];
}

@end
