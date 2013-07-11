/*PRHLineEnumerator.m
 *
 *Created by Peter Hosey on 2004-11-15.
 *Copyright 2004-2008 Peter Hosey. All rights reserved.
 */

#import "PRHLineEnumerator.h"

static NSString *const CRLF = @"\r\n";
static NSString *const LF = @"\n";
static NSString *const CR = @"\r";
static NSString *const FF = @"\f";
static NSString *const LS = @"\u2028";
static NSString *const PS = @"\u2029";

@implementation PRHLineEnumerator
{
	NSScanner *_scanner;
}

//Just a compatibility synonym at this point, for people who were using this class before it required ARC.
+ (instancetype) enumeratorWithString:(NSString *)theString {
	return [self newWithString:theString];
}
+ (instancetype) newWithString:(NSString *)theString {
	return [[self alloc] initWithString:theString];
}
- (instancetype) initWithString:(NSString *)theString {
	self = [super init];
	if(self) {
		_scanner = [[NSScanner alloc] initWithString:theString];
		_scanner.charactersToBeSkipped = [NSCharacterSet characterSetWithRange:(NSRange){ 0, 0 }];
	}
	return self;
}

- (NSString *)nextObject {
	NSString *string = nil, *newlineString = nil;
	NSCharacterSet *newlineCharacterSet = [NSCharacterSet newlineCharacterSet];
	[_scanner scanUpToCharactersFromSet:newlineCharacterSet intoString:&string];
	bool scanPastSucceeded = [_scanner scanString:CRLF intoString:&newlineString];
	if (!scanPastSucceeded)
		scanPastSucceeded = [_scanner scanString:LF intoString:&newlineString];
	if (!scanPastSucceeded)
		scanPastSucceeded = [_scanner scanString:CR intoString:&newlineString];
	if (!scanPastSucceeded)
		scanPastSucceeded = [_scanner scanString:FF intoString:&newlineString];
	if (!scanPastSucceeded)
		scanPastSucceeded = [_scanner scanString:LS intoString:&newlineString];
	if (!scanPastSucceeded)
		scanPastSucceeded = [_scanner scanString:PS intoString:&newlineString];

	if (scanPastSucceeded) {
		//string may be nil if the scanner didn't scan anything. But, if we scanned a newline, that means we have scanned a blank line, not reached the end of the string.
		if (string == nil)
			string = @"";

		if (self.includesNewlines)
			string = [string stringByAppendingString:newlineString];
	}

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
