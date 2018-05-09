//
//  uWSco.m
//  uws-test
//
//  Created by 潘秀清 on 2017/10/22.
//  Copyright © 2017年 潘秀清. All rights reserved.
//

#import "uWebSocket.h"
#import <uWS/uWS.h>

@implementation uWSco {
    uWS::WebSocket<uWS::SERVER> *serverConn;
}

+ (instancetype) initWithMessageDelegate:(id<uWSDelegate>)delegate
{
    uWSco *ws = [[uWSco alloc] init];
    ws.delegate = delegate;
    return ws;
}

- (void)runServer: (uint16)port
{
    uWS::Hub hub;
    
    hub.onMessage([&](uWS::WebSocket<uWS::SERVER> *ws, char *message, size_t length, uWS::OpCode opCode) {
        [_delegate onMessage:message length:length];
    });
    
    hub.onConnection([&](uWS::WebSocket<uWS::SERVER> *ws, uWS::HttpRequest req) {
        if (serverConn == NULL) {
            serverConn = ws;
            [_delegate onConnect];
        } else {
            ws->send("connection exist", uWS::TEXT);
            ws->close();
        }
    });
    
    hub.onDisconnection([&](uWS::WebSocket<uWS::SERVER> *ws, int code, char * msg, size_t length) {
        if (serverConn == ws) {
            [_delegate onDisconnect];
            serverConn = NULL;
        }
    });
    
    //    USE wss://example.com
    //    uS::TLS::Context c = uS::TLS::createContext("ssl/server.crt",
    //                                                "ssl/server.key",
    //                                                "");
    //    if (hub.listen(54321, c)) {
    //        hub.run();
    //    }
    
    if (hub.listen(port)) {
        hub.run();
    }
}

- (void)send:(char *)message len:(size_t)length
{
    if (serverConn == NULL) {
        return;
    }
    serverConn->send(message, length, uWS::BINARY);
}

@end
