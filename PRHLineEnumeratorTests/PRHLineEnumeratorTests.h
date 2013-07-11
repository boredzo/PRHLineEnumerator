//
//  PRHLineEnumeratorTests.h
//  PRHLineEnumeratorTests
//
//  Created by Peter Hosey on 2013-07-10.
//
//

#import <SenTestingKit/SenTestingKit.h>

@interface PRHLineEnumeratorTests : SenTestCase

- (void) testReadingLinesIncludingTerminatorsFromStringThatEndsWithTerminator;
- (void) testReadingLinesIncludingTerminatorsFromStringThatDoesNotEndWithTerminator;
- (void) testReadingLinesExcludingTerminatorsFromStringThatEndsWithTerminator;
- (void) testReadingLinesExcludingTerminatorsFromStringThatDoesNotEndWithTerminator;

- (void) testReadingLinesIncludingOneBlankLineIncludingTerminators;
- (void) testReadingLinesIncludingOneBlankLineExcludingTerminators;

- (void) testReadingLinesFromEmptyStringIncludingTerminators;
- (void) testReadingLinesFromEmptyStringExcludingTerminators;

@end
