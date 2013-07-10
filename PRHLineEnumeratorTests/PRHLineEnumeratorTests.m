//
//  PRHLineEnumeratorTests.m
//  PRHLineEnumeratorTests
//
//  Created by Peter Hosey on 2013-07-10.
//
//

#import "PRHLineEnumeratorTests.h"
#import "PRHLineEnumerator.h"

@implementation PRHLineEnumeratorTests

- (void) testReadingLinesIncludingTerminatorsFromStringThatEndsWithTerminator {
	NSArray *lines = @[
		@"foo\n",
		@"bar\n",
		@"bar\n",
	];
	[self testReadingLines:lines fromString:[lines componentsJoinedByString:@""] includeTerminators:true];
}

- (void) testReadingLinesIncludingTerminatorsFromStringThatDoesNotEndWithTerminator {
	NSArray *lines = @[
		@"foo\n",
		@"bar\n",
		@"bar",
	];
	[self testReadingLines:lines fromString:[lines componentsJoinedByString:@""] includeTerminators:true];
}

- (void) testReadingLinesExcludingTerminatorsFromStringThatEndsWithTerminator {
	NSArray *lines = @[
		@"foo",
		@"bar",
		@"bar",
	];
	[self testReadingLines:lines
	            fromString:[[lines componentsJoinedByString:@"\n"] stringByAppendingString:@"\n"]
		includeTerminators:false];
}

- (void) testReadingLinesExcludingTerminatorsFromStringThatDoesNotEndWithTerminator {
	NSArray *lines = @[
		@"foo",
		@"bar",
		@"bar",
	];
	[self testReadingLines:lines fromString:[lines componentsJoinedByString:@"\n"] includeTerminators:false];
}

- (void) testReadingLines:(NSArray *)lines fromString:(NSString *)string includeTerminators:(bool)includeTerminators {
	PRHLineEnumerator *lineEnum = [PRHLineEnumerator enumeratorWithString:string];
	lineEnum.includesNewlines = includeTerminators;
	NSArray *outputLines = [lineEnum allObjects];
	STAssertEqualObjects(outputLines, lines, @"Got different lines than expected");
}

@end
