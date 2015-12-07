//
//  FacebookImagePickerViewController.m
//  FaceBookApp
//
//  Created by Aditya Narayan on 12/7/15.
//  Copyright © 2015 turntotech.io. All rights reserved.
//

#import "FacebookImagePickerViewController.h"

@interface FacebookImagePickerViewController ()

@end

@implementation FacebookImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Image picker delegates
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  [self.navigationController popToRootViewControllerAnimated:YES];
  [picker popViewControllerAnimated:YES];
  UIImage *image = info[UIImagePickerControllerOriginalImage];
  FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
  photo.image = image;
  photo.userGenerated = YES;
  FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
  content.photos = @[photo];
  
  [FBSDKShareDialog showFromViewController:nil
                               withContent:content
                                  delegate:self];
}


- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
  NSLog(@"%@",results);
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
  [self dismissViewControllerAnimated:YES completion:nil];
  NSLog(@"cancelled");
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
