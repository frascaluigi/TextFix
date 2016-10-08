//
//  ProfileViewController.m
//  TextFix
//
//  Created by Riccardo Gargano on 17/09/16.
//  Copyright © 2016 Riccardo Gargano. All rights reserved.
//

#import "ProfileViewController.h"
#import "TFSettingsModel.h"



@interface ProfileViewController ()

@property (strong, readwrite) TFSettingsModel *model;

@end


@implementation ProfileViewController



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.model = [[TFSettingsModel alloc] init];
    
    self.nameField.returnKeyType = UIReturnKeyDone;
    self.nameField.delegate = self;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSString* name = [self.model readName];
    if (name && name.length) {
        self.label.text = [NSString stringWithFormat: @"Ciao %@! ", name];
        self.nameField.text = name;
    }else{
        self.label.text = @"Inserisci il nome";
    }
    
    
    if ([self.model readPath] && [self.model readPath].length)
        self.avatar.image = [UIImage imageNamed:[self.model readPath]];
}


- (IBAction)selectPhotos:(UIButton *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    self.avatar.image = (UIImage* ) info[UIImagePickerControllerEditedImage];
    
    NSLog(@" string________________ %@ ___________",info[UIImagePickerControllerReferenceURL]);
    // salvo il path
    
    //obtaining saving path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"latest_photo.png"];
    
    NSLog(imagePath);
    
    //extracting image from the picker and saving it
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *imgData = UIImagePNGRepresentation(editedImage);
        [imgData writeToFile:imagePath atomically:YES];
    }
    
    [self.model writePath :imagePath ];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
//
//- (IBAction)textFieldDismiss:(id)sender {
//    [self.nameField resignFirstResponder];
//}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString* name = textField.text;
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (name && name.length) {
        self.label.text = [NSString stringWithFormat: @"Ciao %@! ", name];
        self.nameField.text = name;
        [self.model writeName:name];
        [textField resignFirstResponder];
        return YES;
    }
    self.label.text = @"Inserisci il nome";
    return NO;
    
}


@end
