//
//  pastify.m
//  pastify
//
//  Created by tsung on 13-5-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

// Action Menu developed by Ryan Petrich

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActionMenu/ActionMenu.h"

@implementation UIResponder (pastifyAction)

- (void)dopastify:(id)sender
{
	// TODO: Implement pastify Plugin
}

- (BOOL)canDopastify:(id)sender
{
	return YES;
}

+ (void)load
{
	[[UIMenuController sharedMenuController] registerAction:@selector(dopastify:) title:@"pastify" canPerform:@selector(canDopastify:)];
}

@end
