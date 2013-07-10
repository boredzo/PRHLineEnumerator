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
		_scanner = [[NSScanner alloc] initWithString:theString];
	}
	return self;
}

- (NSString *)nextObject {
//	NSUInteger loc = [_scanner scanLocation];
	NSString *string = nil, *newlineString = nil;
	bool scanUpToSucceeded, scanPastSucceeded;
	scanUpToSucceeded = [_scanner scanUpToString:newline intoString:&string];
	scanPastSucceeded =  [_scanner scanString:newline intoString:&newlineString];

	if(self.includesNewlines && scanPastSucceeded)
		string = [string stringByAppendingString:newlineString];

	[self willChangeValueForKey:@"lineNumber"];
	++_lineNumber;
	[self didChangeValueForKey:@"lineNumber"];

//	NSLog(@"%u@%u %u %u \"%@\"", lineNumber, loc, scanUpToSucceeded, scanPastSucceeded, string);
	return string;
}

@end

@implementation NSString(PRHLineEnumerator)

- (PRHLineEnumerator *)lineEnumerator {
	return [PRHLineEnumerator enumeratorWithString:self];
}

@end
