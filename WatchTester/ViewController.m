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


#pragma mark - WatchConnectivity Delegate Method

- (void) session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.messageLabel.text = message[@"b"];
       // NSLog(@"%@",message);
    });
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss.SSSSS"];
    
    NSString *phoneString = [formatter stringFromDate:[NSDate date]];//The time that phone receives data
    NSString *watchString = message[@"b"];//time watch sent
    
    float phoneTime = [phoneString floatValue];
    float watchTime = [watchString floatValue];
    
    
    float delayTime = phoneTime - watchTime;
    
    NSNumber *delay = [NSNumber numberWithFloat:delayTime];
    NSLog([delay description]);
    
    //[self.timeArray addObject:delay];
    NSNumber *avg;
    
    //NSLog([delay description]);

//    NSNumber *one = [NSNumber numberWithInt:4];
//    NSNumber *two = [NSNumber numberWithInt:3];
//    two = [NSNumber numberWithInt:(([one integerValue])/([two integerValue]))];
//    NSLog([two description]);
    
    //NSLog([delay stringValue]);
    
    if ([delay floatValue] < 0.16) {
        //[self sendMsgToWatchWithString:@"7"];
        [self.timeArray addObject:[NSNumber numberWithInt:7]];
        
    }
    else{
        
        if (0.16 < [delay floatValue] < 0.17) {
            //[self sendMsgToWatchWithString:@"6"];
            [self.timeArray addObject:[NSNumber numberWithInt:6]];
        }
        else{
            
            if (0.17 < [delay floatValue] < 0.18) {
                //[self sendMsgToWatchWithString:@"5"];
                [self.timeArray addObject:[NSNumber numberWithInt:5]];
            }
            else{
                
                if (0.18 < [delay floatValue] < 0.19) {
                    //[self sendMsgToWatchWithString:@"4"];
                    [self.timeArray addObject:[NSNumber numberWithInt:4]];
                }
                else{
                    
                    if (0.19 < [delay floatValue] < 0.20) {
                        //[self sendMsgToWatchWithString:@"3"];
                        [self.timeArray addObject:[NSNumber numberWithInt:3]];
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
    
    
    if ([self.timeArray count] == 12) {
        
        
        
        for (NSNumber *timeItem in self.timeArray) {
            avg = [NSNumber numberWithInt:([avg integerValue] + [timeItem integerValue])];
            
        }
        avg = [NSNumber numberWithInt:([avg integerValue]/12)];
        
        
//        NSLog(@"-----------");
//        NSLog([self.timeArray description]);
//        NSLog([avg description]);
//        NSLog(@"-----------");
        
        
        [self.timeArray removeAllObjects];
        
        [self sendMsgToWatchWithString:[avg stringValue]];
    }
    
    
    
    
}

    
    //[self sendMsgToWatchWithString:[delay stringValue]];



@end
