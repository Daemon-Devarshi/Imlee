//
//  ImleeDragAndDropView.m
//  Imlee
//
//  Created by Devarshi Kulshreshtha on 6/22/12.
//  Copyright 2012 DaemonConstruction. All rights reserved.
//

#import "ImleeDragAndDropView.h"
#import "ImleeModelDelegate.h"

@implementation ImleeDragAndDropView
@synthesize delegate = _delegate;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		
		[self setAnimates:YES]; // to automatically play animated images
		
		// register for all image types
		[self registerForDraggedTypes:[NSImage imagePasteboardTypes]];
    }
    return self;
}

#pragma mark implementing drag and drop
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	if (![[[[self delegate] imageTypes] valueForKey:@"imageTypeName"] containsObject:[[[NSURL URLFromPasteboard:[sender draggingPasteboard]] path] pathExtension]]) {
		return NSDragOperationNone;
	}
	
	return NSDragOperationCopy;
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
	return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	NSPasteboard *pasteboard = [sender draggingPasteboard];
	//FIXME: remove setCurrentImage and use only setCurrentImagePath to show image
	NSImage *anImage = [[NSImage alloc] initWithPasteboard:pasteboard];
	[[self delegate] setCurrentImage:anImage];
	[anImage release];
	[[self delegate] setCurrentImagePath:[[NSURL URLFromPasteboard:pasteboard] path]];
	return YES;
}

#pragma mark handing mouse down action
- (void)mouseDown:(NSEvent *)theEvent
{
	[[self delegate] openImage];
}
@end
