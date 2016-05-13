//
//  ViewController.m
//  WatchTester
//
//  Created by Bernard Yan on 5/11/16.
//  Copyright © 2016 IntBridge. All rights reserved.
//

#import "ViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    NSLog(@"view did load");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendMessageToWatch:(id)sender {
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    [session sendMessage:@{@"a":@"hello"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - WatchConnectivity Delegate Method

- (void) session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.messageLabel.text = message[@"b"];
       // NSLog(@"%@",message);
    });
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss.SSS"];
    
    NSString *msg = [formatter stringFromDate:[NSDate date]];
    
    NSLog(msg);
    
}


@end
