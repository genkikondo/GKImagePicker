//
//  GKImagePicker.m
//  GKImagePicker
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

#import "GKImagePicker.h"

@interface GKImagePicker () <GKImageCropperDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIViewController *presentingViewController;
}
- (void)presentImageCropperWithImage:(UIImage *)image;
@end

@implementation GKImagePicker 

@synthesize delegate = _delegate;
@synthesize cropper = _cropper;

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.cropper = [[GKImageCropper alloc] init];
        self.cropper.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - View control

- (void)presentPickerWithAnchor:(UIView*)anchor from:(UIViewController*)viewController{
    // save presenting view controller for later show image cropper view, and photo view
    self->presentingViewController = viewController;
    
    // **********************************************
    // * Show action sheet that will allow image selection from camera or gallery
    // **********************************************
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alert.popoverPresentationController.sourceView = anchor;
    alert.popoverPresentationController.sourceRect = CGRectMake(anchor.bounds.size.width / 2.0f, anchor.bounds.size.height / 2.0f, 1.0f, 1.0f);
    alert.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Image from Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showCameraImagePicker];
    }];
    UIAlertAction *gallery = [UIAlertAction actionWithTitle:@"Image from Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showGalleryImagePicker];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // do nothing
    }];
    
    [alert addAction:camera];
    [alert addAction:gallery];
    [alert addAction:cancel];
    [viewController presentViewController:alert animated:YES completion:nil];
}

- (void)presentImageCropperWithImage:(UIImage *)image {
    // **********************************************
    // * Show GKImageCropper
    // **********************************************
    self.cropper.image = image;
    [self->presentingViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:self.cropper] animated:YES completion:nil];
}

#pragma mark - Image picker methods

- (void)showCameraImagePicker {
#if TARGET_IPHONE_SIMULATOR
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Simulator" message:@"Camera not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
#elif TARGET_OS_IPHONE
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self->presentingViewController presentViewController:picker animated:YES completion:nil];
#endif
}

- (void)showGalleryImagePicker {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self->presentingViewController presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self presentImageCropperWithImage:image];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    // Extract image from the picker
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self presentImageCropperWithImage:image];
    }
}

#pragma mark - GKImageCropper delegate methods

- (void)imageCropperDidFinish:(GKImageCropper *)imageCropper withImage:(UIImage *)image {
    [self.delegate imagePickerDidFinish:self withImage:image];
}

@end
