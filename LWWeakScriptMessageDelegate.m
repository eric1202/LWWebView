//
//  LWWeakScriptMessageDelegate.m

#import "LWWeakScriptMessageDelegate.h"

@interface LWWeakScriptMessageDelegate ()

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

@end

@implementation LWWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

- (void)dealloc {
}

@end
