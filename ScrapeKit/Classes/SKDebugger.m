//
//  SKDebugger.m
//  ScrapeKit
//
//  Created by Craig Edwards on 20/12/12.
//  Copyright (c) 2012 BlackDog Foundry. All rights reserved.
//

#import <ScrapeKit/ScrapeKit.h>

@implementation SKDebugger

-(id)init {
	self = [super init];
	if (self != nil) {
		_indent = @"";
	}
	return self;
}

-(void)enteringFunction:(SKFunction *)function textStack:(NSArray *)textStack {
	_indent = [_indent stringByAppendingString:@"  "];
}

-(void)exitingFunction:(SKFunction *)function textStack:(NSArray *)textStack {
	_indent = [_indent substringFromIndex:2];
}

-(void)executingRule:(SKRule *)rule textStack:(NSArray *)textStack  {
	[self outputMessage:rule message:@"---------------------------------------------------"];
}

-(void)outputMessage:(SKRule *)rule message:(NSString *)message {
	NSString *ruleName = [rule verb];
	if ([rule isKindOfClass:[SKLabelRule class]])
		ruleName = [(SKLabelRule *)rule label];
	NSLog(@"%@%@[%@] %@", _indent, [[rule function] name], ruleName, message);
}

-(void)dumpTextStack:(NSArray *)textStack {
	NSUInteger i = 0;
	for (SKTextBuffer *buffer in [textStack reverseObjectEnumerator]) {
		NSLog(@"%@  %@", _indent, [NSString stringWithFormat:@"%ld %@", (unsigned long)i++, [buffer debugDescription]]);
	}
}

@end
