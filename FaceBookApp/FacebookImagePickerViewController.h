//
//  FacebookImagePickerViewController.h
//  FaceBookApp
//
//  Created by Aditya Narayan on 12/7/15.
//  Copyright © 2015 turntotech.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface FacebookImagePickerViewController : UIImagePickerController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, FBSDKSharingDelegate>

@end
