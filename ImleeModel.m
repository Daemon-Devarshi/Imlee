//
//  ImleeModel.m
//  Imlee
//
//  Created by Devarshi Kulshreshtha on 6/21/12.
//  Copyright 2012 DaemonConstruction. All rights reserved.
//

#import "ImleeModel.h"


@implementation ImleeModel

#pragma mark synthesises
@synthesize imageTypes = _imageTypes;
@synthesize currentImage = _currentImage;
@synthesize currentImagePath = _currentImagePath;
@synthesize currentImageType = _currentImageType;
@synthesize imageTypeSelectedDict = _imageTypeSelectedDict;
@synthesize isSelectedImageTypeSameAsCurrentImageType = _isSelectedImageTypeSameAsCurrentImageType;

#pragma mark initialization
- (id)init
{
	if (self = [super init]) {
		
		// code to initialize certain properties 
		self.isSelectedImageTypeSameAsCurrentImageType = YES;
		
		NSDictionary *pngTypeDict  = [[NSDictionary alloc] initWithObjectsAndKeys:@"png",@"imageTypeName",[NSNumber numberWithInt:NSPNGFileType], @"imageTypeValue",nil];
		NSDictionary *gifTypeDict  = [[NSDictionary alloc] initWithObjectsAndKeys:@"gif",@"imageTypeName",[NSNumber numberWithInt:NSGIFFileType], @"imageTypeValue",nil];
		NSDictionary *bmpTypeDict  = [[NSDictionary alloc] initWithObjectsAndKeys:@"bmp",@"imageTypeName",[NSNumber numberWithInt:NSBMPFileType], @"imageTypeValue",nil];
		NSDictionary *jpgTypeDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"jpg",@"imageTypeName",[NSNumber numberWithInt:NSJPEGFileType], @"imageTypeValue",nil];
		NSDictionary *jpegTypeDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"jpeg",@"imageTypeName",[NSNumber numberWithInt:NSJPEGFileType], @"imageTypeValue",nil];
		NSDictionary *tiffTypeDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"tiff",@"imageTypeName",[NSNumber numberWithInt:NSTIFFFileType], @"imageTypeValue",nil];
		
		NSArray *tempArray = [[NSArray alloc] initWithObjects:pngTypeDict,gifTypeDict,bmpTypeDict,jpgTypeDict,jpegTypeDict,tiffTypeDict,nil];
		self.imageTypes = tempArray;
		[tempArray release];
		
		[pngTypeDict release];
		[gifTypeDict release];
		[bmpTypeDict release];
		[jpgTypeDict release];
		[jpegTypeDict release];
		[tiffTypeDict release];
		
		// adding observer
		[self addObserver:self forKeyPath:@"currentImagePath" options:NSKeyValueObservingOptionNew context:NULL];
		[self addObserver:self forKeyPath:@"currentImageType" options:NSKeyValueObservingOptionNew context:NULL];
		[self addObserver:self forKeyPath:@"imageTypeSelectedDict" options:NSKeyValueObservingOptionNew context:NULL];
	}
	return self;
}

#pragma mark observing keys
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"currentImagePath"]) 
	{
		if ([[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
			self.currentImageType = nil;
		}
		else {
			self.currentImageType = [[change objectForKey:NSKeyValueChangeNewKey] pathExtension];
		}

				
	}
	else if ([keyPath isEqualToString:@"currentImageType"])
	{
		// current image type is nil so image type selected should also be nil
		if (self.currentImageType == nil) 
		{
			self.imageTypeSelectedDict = nil; 
		}
		// current image type is changed so selected image type should also be changed
		else
		{
			//TODO: try it with predicate with block
			NSPredicate *imageTypeFilterPredicate = [NSPredicate predicateWithFormat:@"imageTypeName like %@",self.currentImageType];
			self.imageTypeSelectedDict = [[self.imageTypes filteredArrayUsingPredicate:imageTypeFilterPredicate] objectAtIndex:0]; 
		}

	}
	// condition check to enable-disable save button
	else if ([keyPath isEqualToString:@"imageTypeSelectedDict"])
	{
		// current image path is nil so save button should be disabled
		if (self.imageTypeSelectedDict == nil) 
		{
			self.isSelectedImageTypeSameAsCurrentImageType = YES;
		}
		// pop up button value is same as dropped image type so save button should be disabled
		else if ([[[change objectForKey:NSKeyValueChangeNewKey] objectForKey:@"imageTypeName"] isEqualToString:[self.currentImagePath pathExtension]]) 
		{
			self.isSelectedImageTypeSameAsCurrentImageType = YES;
			
		}
		// pop up button value is not same as dropped image type so save button should be enabled
		else 
		{
			self.isSelectedImageTypeSameAsCurrentImageType = NO;
		}
	}
	
}
#pragma mark actions associated with UI elements
- (void)save
{
	NSBitmapImageRep *bits = [[self.currentImage representations] objectAtIndex:0];
	
	NSString *imageNewExtension = [self.imageTypeSelectedDict objectForKey:@"imageTypeName"];
	NSData *data = [bits representationUsingType:[[self.imageTypeSelectedDict objectForKey:@"imageTypeValue"] intValue] properties:nil];
	
	//changing name of file 
	NSString *imagePathWithoutExtension = [self.currentImagePath stringByDeletingPathExtension];
	NSString *imagePathWithNewExtension = [[NSString alloc] initWithFormat:@"%@.%@",imagePathWithoutExtension,imageNewExtension];
	
	[data writeToFile:imagePathWithNewExtension atomically:NO];
	
	// re-assigning values to properties
	self.currentImagePath = imagePathWithNewExtension;
	[imagePathWithNewExtension release];
}
- (void)clearAll
{
	self.currentImage = nil; // showing no image on image view
	self.currentImagePath = nil; // showing no image path
}
- (void)openImage
{
	[[NSWorkspace sharedWorkspace] openFile:self.currentImagePath];
}

#pragma mark releasing used resources
- (void)dealloc
{
	[_imageTypes release];
	[_currentImage release];
	[_currentImagePath release];
	[_currentImageType release];
	[_imageTypeSelectedDict release];
	[super dealloc];
}
@end
