//
//  GKImageCropper.h
//  GKImageEditor
//
//  Created by Genki Kondo on 9/18/12.
//  Copyright (c) 2012 Genki Kondo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol GKImageCropperDelegate;

@interface GKImageCropper : UIViewController {
    UIImage *image;
    id<GKImageCropperDelegate> delegate;
    CGSize cropSize;
    BOOL rescaleImage;
    double rescaleFactor;
    BOOL dismissAnimated;
    UIColor *overlayColor;
    UIColor *innerBorderColor;
}

@property (nonatomic, assign) id<GKImageCropperDelegate> delegate;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) CGSize cropSize;
@property (nonatomic) BOOL rescaleImage;
@property (nonatomic) double rescaleFactor;
@property (nonatomic) BOOL dismissAnimated;
@property (nonatomic, retain) UIColor *overlayColor;
@property (nonatomic, retain) UIColor *innerBorderColor;

-(id)initWithImage:(UIImage*)theImage withCropSize:(CGSize)theSize willRescaleImage:(BOOL)willRescaleImage withRescaleFactor:(double)theFactor willDismissAnimated:(BOOL)willDismissAnimated;

@end

@protocol GKImageCropperDelegate <NSObject>
- (void)imageCropperDidFinish:(GKImageCropper *)imageCropper withImage:(UIImage *)image;
@end