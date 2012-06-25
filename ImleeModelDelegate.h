//
//  ImleeModelDelegate.h
//  Imlee
//
//  Created by Devarshi Kulshreshtha on 6/22/12.
//  Copyright 2012 DaemonConstruction. All rights reserved.
//

/* 
 A protocol, used to declare methods which are used in ImleeDragAndDropView but defined in ImleeModel
 */

#import <Cocoa/Cocoa.h>


@protocol ImleeModelDelegate

- (NSArray *)imageTypes;
- (void)setCurrentImagePath:(NSString *)anImagePath;
- (void)setCurrentImage:(NSImage *)anImage;
- (void)openImage;
@end
