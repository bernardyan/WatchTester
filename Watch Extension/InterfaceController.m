//
//  InterfaceController.m
//  Watch Extension
//
//  Created by Bernard Yan on 5/11/16.
//  Copyright © 2016 IntBridge. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#include <stdlib.h>



@interface InterfaceController()
@property (strong, nonatomic)NSTimer *myTimer;
@property (strong, nonatomic)NSData *dataPack;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *indicatorLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *statusLabel;


@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    //self.dataPack = [self create1mbRandomNSData];
    
    [self.myTimer invalidate];
    
    
    
    
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)sendMessage {
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss.SSSSS"];
    
    NSString *timeMsg = [formatter stringFromDate:[NSDate date]];
    
    
    [session sendMessage:@{@"time":timeMsg} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {

        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void) session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler{
    
    if (message[@"indicator"] != nil) {
        [[self indicatorLabel] setText:message[@"indicator"]];
    }else{
        [[self statusLabel] setText:message[@"status_marker"]];
    }
    
    
    

}

- (IBAction)stopAction {
    
    [self.myTimer invalidate];
    
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    [session sendMessage:@{@"test_marker":@"---The end of test---"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    [session sendMessage:@{@"status_marker":@"STOPPED"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
}


- (IBAction)fiveMeterTestAction {
    
    [self.myTimer invalidate];
    
    
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    [session sendMessage:@{@"test_marker":@"---Start 5m test---"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    [session sendMessage:@{@"status_marker":@"LIVE"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendMessage) userInfo:nil repeats:YES];
    
    
    
}

- (IBAction)tenMeterTestAction {
    
    [self.myTimer invalidate];
    
    
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    [session sendMessage:@{@"test_marker":@"---Start 10m test---"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    [session sendMessage:@{@"status_marker":@"LIVE"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendMessage) userInfo:nil repeats:YES];

    
    
    
}

- (IBAction)twentyMeterTestAction {
    
    [self.myTimer invalidate];
    
    
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    [session sendMessage:@{@"test_marker":@"---Start 20m test---"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    [session sendMessage:@{@"status_marker":@"LIVE"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendMessage) userInfo:nil repeats:YES];

}

- (IBAction)fiftyMeterTestAction {
    
    [self.myTimer invalidate];
    
    
    WCSession* session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    
    [session sendMessage:@{@"test_marker":@"---Start 50m test---"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    [session sendMessage:@{@"status_marker":@"LIVE"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendMessage) userInfo:nil repeats:YES];
  
    
}







//-(NSData*)create1mbRandomNSData {
//    int oneMb = 256;//256B
//    NSMutableData* theData = [NSMutableData dataWithCapacity:oneMb];
//    for( unsigned int i = 0 ; i < oneMb/4 ; ++i )
//    {
//        u_int32_t randomBits = 1;
//        [theData appendBytes:(void*)&randomBits length:4];
//    }
//    return theData;
//}




@end



