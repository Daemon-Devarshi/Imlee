//
//  ImleeDragAndDropView.h
//  Imlee
//
//  Created by Devarshi Kulshreshtha on 6/22/12.
//  Copyright 2012 DaemonConstruction. All rights reserved.
//

/* 
 A subclas of NSImageView, here methods for drag and drop and mouse down are implemented.
 */

#import <Cocoa/Cocoa.h>


@protocol ImleeModelDelegate;

@interface ImleeDragAndDropView : NSImageView {

	id _delegate;
}
@property (assign) id<ImleeModelDelegate> delegate;
@end
