//
//  ViewController.m
//  FaceBookApp
//
//  Created by Aditya Narayan on 11/30/15.
//  Copyright © 2015 turntotech.io. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *imagePickerButton;
@property (strong, nonatomic) IBOutlet UITextField *outputTextView;
@property (strong, nonatomic) UIImagePickerController *imagePickerProperty;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if([FBSDKAccessToken currentAccessToken]){
    [self getEmail];
  } else {
    self.imagePickerButton.enabled = false;
    self.outputTextView.text = @"";
  }
  
  FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
  loginButton.center = self.view.center;
  loginButton.readPermissions = @[@"email"];
  [loginButton setDelegate:self];
  [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark Facebook login delegate methods
- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
  NSLog(@"Login");
  NSLog(@"%@",result);
  self.imagePickerButton.enabled = true;
  [self getEmail];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
  NSLog(@"Logout!!!");
  self.imagePickerButton.enabled = false;
  self.outputTextView.text = @"";
}

- (IBAction)shareImage:(id)sender {
  FacebookImagePickerViewController *imagePicker = [[FacebookImagePickerViewController alloc] init];
  imagePicker.delegate = imagePicker;
  imagePicker.allowsEditing = false;
  imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)getEmail{
  
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  [params setValue:@"id,name,email" forKey:@"fields"];
  
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"/me"
                                parameters:params
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        id result,
                                        NSError *error) {
    self.outputTextView.text = [NSString stringWithFormat:@"Hello %@ (%@)",[result valueForKey:@"name"],[result valueForKey:@"email"]];
  }];
  
}




@end
