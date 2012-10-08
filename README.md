GKImagePicker
=============

An enhancement of UIImagePicker in iOS to enable image cropping at any specified size as well as image rotation. So easy to use, even your computer illiterate grandma can (probably) figure it out.

## Features

+ Zoom and crop in any way you wish
+ Rotate image (tap the screen to show menu)
+ Takes into account UIImageOrientation so the images will show up the way they were intended
+ Rescale image after cropping, or keep image size as-is

## Setup

Copy all the files in GKImagePicker (including subfolders) into your project. Be sure to add them to your project target under "Build Phases" > "Compile Sources"

## Use

Import GKImagePicker into your project:

    #import "GKImagePicker.h"

Initialize and set delegate:

    GKImagePicker *picker = [[GKImagePicker alloc] init];
    self.picker.delegate = self;
    
Modify the crop size:

    self.picker.cropper.cropSize = CGSizeMake(88.,88.);

RescaleImage determines whether you want to rescale the image after it has been cropped. For example, given a 1000x1000 image and a 10x10 crop size, if rescaleImage == YES and rescaleFactor == 2.0, the image size in the end would be 20x20. However, if rescaleImage == NO, it would keep whatever was shown in the crop box without rescaling - if the image was zoomed out all the way, the resulting image would be 1000x1000.

    self.picker.cropper.rescaleImage = YES;
    self.picker.cropper.rescaleFactor = 2.0;

DismissAnimated determines whether the cropper will be dismissed at the very end with an animation.

    self.picker.cropper.dismissAnimated = YES;
    
Show the GKImagePicker:

    [self.picker presentPicker];