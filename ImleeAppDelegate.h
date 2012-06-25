//
//  ImleeAppDelegate.h
//  Imlee
//
//  Created by Devarshi Kulshreshtha on 6/21/12.
//  Copyright 2012 DaemonConstruction. All rights reserved.
//

/*
 In this class, model class is initialized and assigned as delegate for imleeDragAndDropView
 */

#import <Cocoa/Cocoa.h>
#import "ImleeModel.h"
#import "ImleeDragAndDropView.h"

@interface ImleeAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	ImleeDragAndDropView *_imleeDragAndDropView;
	
	ImleeModel *_imleeModel;
}

@property (assign) IBOutlet ImleeDragAndDropView *imleeDragAndDropView;
@property (assign) IBOutlet NSWindow *window;
@property (readwrite, retain) ImleeModel *imleeModel;

@end
