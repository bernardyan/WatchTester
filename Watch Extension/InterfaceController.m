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


@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.dataPack = [self create1mbRandomNSData];
    
    [self.myTimer invalidate];
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendMessage) userInfo:nil repeats:YES];
    
    
    
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
    
    NSString *msg = [formatter stringFromDate:[NSDate date]];
    
    
    [session sendMessage:@{@"b":msg, @"m": self.dataPack} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {

        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void) session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler{
    [[self messageLabel] setText:message[@"indicator"]];
    //NSLog(message);
}

-(NSData*)create1mbRandomNSData
{
    int oneMb = 256;//256B
    NSMutableData* theData = [NSMutableData dataWithCapacity:oneMb];
    for( unsigned int i = 0 ; i < oneMb/4 ; ++i )
    {
        u_int32_t randomBits = 1;
        [theData appendBytes:(void*)&randomBits length:4];
    }
    return theData;
}


@end



