GKImagePicker
=============

An enhancement of UIImagePicker in iOS to enable image cropping at any specified size as well as image rotation. So easy to use, even your computer illiterate grandma can (probably) figure it out.

## Features

+ Grab a new image from your camera or an existing image from your gallery
+ Zoom and crop in any way you wish
+ Rotate image (tap the screen to show menu)
+ Takes into account UIImageOrientation so the images will show up the way they were intended
+ Rescale image after cropping, or keep image scale as-is

## Setup

Copy all the files in GKImagePicker (including subfolders) into your project. Be sure to add them to your project target under "Build Phases" > "Compile Sources".

## Use

### The Short Version

    GKImagePicker *picker = [[GKImagePicker alloc] init];
    picker.delegate = self;
    picker.cropper.cropSize = CGSizeMake(160.0, 80.0);
    picker.cropper.rescaleImage = YES;
    picker.cropper.rescaleFactor = 2.0;
    picker.cropper.dismissAnimated = YES;
    [picker presentPicker];

Or, if you already have the image you want to crop, you can skip the picker and go straight to the cropper:

    GKImageCropper *cropper = [[GKImageCropper alloc] init];
    cropper.delegate = self;
    cropper.image = yourImage;
    cropper.cropSize = CGSizeMake(160.0, 80.0);
    cropper.rescaleImage = YES;
    cropper.rescaleFactor = 2.0;
    cropper.dismissAnimated = YES;
    cropper.image = yourImage;
    [self presentModalViewController:[[UINavigationController alloc] initWithRootViewController:cropper] animated:YES];

### The Long Version

Import GKImagePicker:

    #import "GKImagePicker.h"

Implement the GKImagePickerDelegate in your view controller:

    @interface ViewController () <…, GKImagePickerDelegate> {

Initialize and set delegate:

    GKImagePicker *picker = [[GKImagePicker alloc] init];
    picker.delegate = self;
    
Modify the crop size:

    picker.cropper.cropSize = CGSizeMake(88.,88.);

rescaleImage determines whether you want to rescale the image after it has been cropped. For example, given a 1000x1000 image and a 10x10 crop size, if rescaleImage == YES and rescaleFactor == 2.0, the image size in the end would be 20x20. However, if rescaleImage == NO, it would keep whatever was shown in the crop box without rescaling - if the image was zoomed out all the way, the resulting image would be 1000x1000.

    picker.cropper.rescaleImage = YES;
    picker.cropper.rescaleFactor = 2.0;

dismissAnimated determines whether the cropper will be dismissed at the very end with an animation.

    picker.cropper.dismissAnimated = YES;
    
Show the GKImagePicker:

    [picker presentPicker];
    
Add a delegate method to get back the final cropped/resized image:

    - (void)imagePickerDidFinish:(GKImagePicker *)imagePicker withImage:(UIImage *)image {
        // Do whatever you want with the image. I won't judge.
    }