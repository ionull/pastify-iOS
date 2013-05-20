//
//  pastify.m
//  pastify
//
//  Created by tsung on 13-5-3.
//  Copyright (c) 2013年 Tsung W.<tsung.bz@gmail.com>. All rights reserved.
//

// Action Menu developed by Ryan Petrich

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActionMenu/ActionMenu.h"
#import "AFNetworking/AFNetworking.h"

@implementation UIResponder (pastifyAction)

- (void)dopastify:(id)sender
{
    // TODO: Implement pastify Plugin

    NSString* backupText = [[UIPasteboard generalPasteboard] string];
    [self copy:sender];
    NSString* selectText = [[UIPasteboard generalPasteboard] string];
    
    [UIPasteboard generalPasteboard].string = backupText;
    
    NSURL *url = [NSURL URLWithString:@"http://10.10.10.100:3000/paste"];
    
    if(selectText.length == 0 || [selectText isEqualToString:backupText]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSLog(@"pastify: %@", [JSON valueForKeyPath:@"text"]);
            [UIPasteboard generalPasteboard].string = [[JSON valueForKeyPath:@"text"] copy];
            [self paste:nil];
        } failure:nil];
        [operation start];
    } else {
        AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
        NSLog(@"client url: %@", [client baseURL]);
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:selectText, @"text", @"ios", @"os", nil];
        NSURLRequest *request = [client requestWithMethod:@"POST" path:@"" parameters:params];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            //
        } failure:nil];
        [operation start];
    }
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
