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

@property (strong, nonatomic) NSMutableArray *timeArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    NSLog(@"view did load");
    self.timeArray = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendMessageToWatch:(id)sender {
    
}

- (void)sendMsgToWatchWithString:(NSString *)signal {
    
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    
    
    [session sendMessage:@{@"indicator": signal} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)sendStatusToWatchWithString:(NSString*)status {
    
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    [session sendMessage:@{@"status_marker": status} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark - WatchConnectivity Delegate Method

- (void) session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.messageLabel.text = message[@"time"];
      
    });//set the label on iphone to the time that watch sends msg
    
    if (message[@"status_marker"] != nil) {
        [self sendStatusToWatchWithString:message[@"status_marker"]];
    }//send the status to phone(this makes sure the session is started when signal is bad)
    

    
    NSLog(message[@"test_marker"]);//log the beginning of a test session
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss.SSSSS"];

    NSString *phoneString = [formatter stringFromDate:[NSDate date]];//The time that phone receives msg
    NSString *watchString = message[@"time"];//time watch sent msg
    
    float phoneTime = [phoneString floatValue];
    float watchTime = [watchString floatValue];
    float delayTime = phoneTime - watchTime;
    //time difference
    
    NSNumber *delay = [NSNumber numberWithFloat:delayTime];
    NSLog([delay description]);//log time difference (todo: the difference is negative at the beginning of a min)
    
    
    NSNumber *avg;
    
    //NSLog([delay description]);

//    NSNumber *one = [NSNumber numberWithInt:4];
//    NSNumber *two = [NSNumber numberWithInt:3];
//    two = [NSNumber numberWithInt:(([one integerValue])/([two integerValue]))];
//    NSLog([two description]);
    
    //NSLog([delay stringValue]);
    
    if ([delay floatValue] < 0.16) {
        //[self sendMsgToWatchWithString:@"7"];
        [self.timeArray addObject:[NSNumber numberWithInt:4]];
        
    }
    else{
        
        if (0.16 < [delay floatValue] < 0.17) {
            //[self sendMsgToWatchWithString:@"6"];
            [self.timeArray addObject:[NSNumber numberWithInt:4]];
        }
        else{
            
            if (0.17 < [delay floatValue] < 0.18) {
                //[self sendMsgToWatchWithString:@"5"];
                [self.timeArray addObject:[NSNumber numberWithInt:3]];
            }
            else{
                
                if (0.18 < [delay floatValue] < 0.19) {
                    //[self sendMsgToWatchWithString:@"4"];
                    [self.timeArray addObject:[NSNumber numberWithInt:3]];
                }
                else{
                    
                    if (0.19 < [delay floatValue] < 0.20) {
                        //[self sendMsgToWatchWithString:@"3"];
                        [self.timeArray addObject:[NSNumber numberWithInt:2]];
                    }else{
                        
                        if (0.20 < [delay floatValue] < 0.21) {
                            //[self sendMsgToWatchWithString:@"2"];
                            [self.timeArray addObject:[NSNumber numberWithInt:2]];
                        }else{
                            //[self sendMsgToWatchWithString:@"1"];
                            [self.timeArray addObject:[NSNumber numberWithInt:1]];
                            
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    
    if ([self.timeArray count] == 3) {
        
        
        
        for (NSNumber *timeItem in self.timeArray) {
            avg = [NSNumber numberWithInt:([avg integerValue] + [timeItem integerValue])];
            
        }
        avg = [NSNumber numberWithInt:([avg integerValue]/3)];
        
        
        
        [self.timeArray removeAllObjects];
        
        [self sendMsgToWatchWithString:[avg stringValue]];
    }
    
    
    
    
}



@end
