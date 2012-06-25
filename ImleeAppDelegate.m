//
//  ImleeAppDelegate.m
//  Imlee
//
//  Created by Devarshi Kulshreshtha on 6/21/12.
//  Copyright 2012 DaemonConstruction. All rights reserved.
//

#import "ImleeAppDelegate.h"

@implementation ImleeAppDelegate

@synthesize window;
@synthesize imleeModel = _imleeModel;
@synthesize imleeDragAndDropView = _imleeDragAndDropView;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// code to initialize application 
	
	[self willChangeValueForKey:@"imleeModel"];
	_imleeModel = [[ImleeModel alloc] init];
	[self didChangeValueForKey:@"imleeModel"];
	
	[self.imleeDragAndDropView setDelegate:self.imleeModel];
}

/*
 To re-open window on click of dock icon, if it is closed by click on red(close) button
 */
- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
	if (flag) {
		return NO;
	}
	
	[self.window makeKeyAndOrderFront:self];
	return NO;
}
- (void)dealloc
{
	[_imleeModel release];
	[super dealloc];
}
@end
