//
//  ShareViewController.m
//  UmengSdkExample
//
//  Created by lansterwang on 2021/11/4.
//

#import "ShareViewController.h"
#import "ShareHelper.h"
@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)shareweixin:(id)sender {
  [[ShareHelper sharedInstance] shareWithType:1 title:@"this is title" content:@"content" url:@"https://www.baidu.com" image:nil];
  
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
