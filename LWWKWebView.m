//
//  LWWKWebView.m
//  wkwebview
//

#import "LWWKWebView.h"
#import "LWWeakScriptMessageDelegate.h"

@interface LWWKWebView () <WKScriptMessageHandler>

@property (nonatomic, strong) NSMutableDictionary *scriptMessageHandler;

@end

@implementation LWWKWebView

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    void (^messageHandler)(id) = [_scriptMessageHandler objectForKey:message.name];
    if (messageHandler) {
        messageHandler(message.body);
    }
}

#pragma mark - add messageHandler
- (void)lw_addScriptMessageWithName:(NSString *)messageName completionHandler:(void (^)(id))completionHandler {
    [self.configuration.userContentController addScriptMessageHandler:[[LWWeakScriptMessageDelegate alloc] initWithDelegate:self] name:messageName];
    if (completionHandler) {
        [self.scriptMessageHandler setObject:completionHandler forKey:messageName];
    }
}

#pragma mark given javaScript
- (void)lw_evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler {
    [self evaluateJavaScript:javaScriptString
           completionHandler:^(id response, NSError *error) {
               if (completionHandler) {
                   completionHandler(response, error);
               }
           }];
}

- (void)dealloc {
    // remove messageHandler
    [self.scriptMessageHandler enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
        [self.configuration.userContentController removeScriptMessageHandlerForName:key];
    }];
    [self.scriptMessageHandler removeAllObjects];
}

#pragma mark - lazyloading
- (NSMutableDictionary *)scriptMessageHandler {
    if (!_scriptMessageHandler) {
        _scriptMessageHandler = [NSMutableDictionary dictionary];
    }
    return _scriptMessageHandler;
}

@end
