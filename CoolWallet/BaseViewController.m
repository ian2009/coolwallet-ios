//
//  BaseViewController.m
//  CoolWallet
//
//  Created by 鄭斐文 on 2015/10/8.
//  Copyright © 2015年 MAC-BRYAN. All rights reserved.
//

#import "BaseViewController.h"

CwManager *cwManager;

@interface BaseViewController ()
{
    MBProgressHUD *mHUD;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cwManager = [CwManager sharedManager];
    cwManager = self.cwManager;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.cwManager.delegate = self;
    self.cwManager.connectedCwCard.delegate = self;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.cwManager.connectedCwCard.mode != nil && self.cwManager.connectedCwCard.mode.integerValue == CwCardModeNormal) {
        [self.cwManager.connectedCwCard saveCwCardToFile];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showIndicatorView:(NSString *)Msg {
    if (mHUD != nil) {
        mHUD.labelText = Msg;
        return;
    }
    
    mHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:mHUD];
    
    //如果设置此属性则当前的view置于后台
    mHUD.dimBackground = YES;
    mHUD.labelText = Msg;
    
    [mHUD show:YES];
}

- (void) performDismiss
{
    if(mHUD != nil) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        mHUD = nil;
    }
}

-(BOOL) isLoadingFinish
{
    return mHUD == nil;
}

-(void) showHintAlert:(NSString *)title withMessage:(NSString *)message withOKAction:(UIAlertAction *)okAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) showHintAlert:(NSString *)title withMessage:(NSString *)message withActions:(NSArray *)actions
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
    }
}

#pragma mark - CwCard Delegates
-(void) didCwCardCommand
{
    
}

-(void) didCwCardCommandError:(NSInteger)cmdId ErrString:(NSString *)errString
{
    NSLog(@"%@ didCwCardCommandError: %ld, ErrString: %@", self, (long)cmdId, errString);
    
    if (DEBUG) {
        NSString *msg = [NSString stringWithFormat:@"Cmd %02lX %@", (long)cmdId, errString];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Command Error"
                                                       message: msg
                                                      delegate: nil
                                             cancelButtonTitle: nil
                                             otherButtonTitles:@"OK",nil];
        
        [alert show];
    }
}

#pragma mark - CwManager Delegate
-(void) didDisconnectCwCard: (NSString *)cardName
{
    NSLog(@"didDisconnectCwCard");
    [self performDismiss];
    
    //Add a notification to the system
    UILocalNotification *notify = [[UILocalNotification alloc] init];
    notify.alertBody = [NSString stringWithFormat:@"%@ Disconnected", cardName];
    notify.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow: notify];
    
    // Get the storyboard named secondStoryBoard from the main bundle:
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *listCV = (UIViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"CwMain"];
    [self.parentViewController presentViewController:listCV animated:YES completion:nil];
    
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
