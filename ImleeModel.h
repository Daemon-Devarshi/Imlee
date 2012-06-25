//
//  ImleeModel.h
//  Imlee
//
//  Created by Devarshi Kulshreshtha on 6/21/12.
//  Copyright 2012 DaemonConstruction. All rights reserved.
//

/*
 This class acts as model layer
 */

#import <Cocoa/Cocoa.h>
#import "ImleeModelDelegate.h"

@interface ImleeModel : NSObject <ImleeModelDelegate>{
	
	// used from ImleeDragAndDropView
	NSArray  *_imageTypes;
	NSImage  *_currentImage;
	NSString *_currentImagePath;

	// used within class, required in bindings
	NSString *_currentImageType;
	BOOL      _isSelectedImageTypeSameAsCurrentImageType;
	NSDictionary *_imageTypeSelectedDict;
}
@property (assign) BOOL isSelectedImageTypeSameAsCurrentImageType;

@property (readwrite, retain) NSArray *imageTypes;
@property (readwrite, retain) NSImage *currentImage;
@property (readwrite, retain) NSString *currentImagePath;

@property (readwrite, retain) NSString *currentImageType;
@property (readwrite, retain) NSDictionary *imageTypeSelectedDict;

- (void)save;
- (void)clearAll;
- (void)openImage;
@end
