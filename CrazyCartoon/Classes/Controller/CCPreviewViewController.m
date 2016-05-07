//
//  CCPreviewViewController.m
//  CrazyCartoon
//
//  Created by Tarena on 16/4/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CCPreviewViewController.h"
#import "MBProgressHUD.h"

@interface CCPreviewViewController ()

- (IBAction)savePicture:(id)sender;

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;



@end

@implementation CCPreviewViewController


- (IBAction)savePicture:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        UIImageWriteToSavedPhotosAlbum(self.imageV.image, nil, nil, nil);
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"你的作品在相册！快去看！";
            [hud hide:YES afterDelay:1.0];
        });
    });
    
    
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageV.image = self.image;
    
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

@end
