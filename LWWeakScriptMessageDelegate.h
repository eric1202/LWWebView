//
//  LWWeakScriptMessageDelegate.h
//  LiwaiU
//
//  Created by liwai on 2017/6/1.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

/*************用来销毁界面，不使用该代理不能释放，造成内存泄漏***************/

@interface LWWeakScriptMessageDelegate : NSObject <WKScriptMessageHandler>

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
