//
//  uWebSocket.h
//  uWebSocket
//
//  Created by 潘秀清 on 2018/5/9.
//  Copyright © 2018年 潘秀清. All rights reserved.
//

#ifndef uWebSocket_h
#define uWebSocket_h

#import <Foundation/Foundation.h>
@protocol uWSDelegate

- (void)onMessage:(char *)message length:(size_t)length;
- (void)onConnect;
- (void)onDisconnect;

@end

@interface uWSco : NSObject

@property(nonatomic, strong) id<uWSDelegate> delegate;

+ (instancetype)initWithMessageDelegate: (id<uWSDelegate>)delegate;
- (void)runServer: (uint16)port;
- (void)send: (char *)str len:(size_t)length;

@end




#endif /* uWebSocket_h */
