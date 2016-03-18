//
//  SecondViewController.m
//  1111
//
//  Created by yangyue on 15/11/18.
//  Copyright © 2015年 com.yintai.iphone. All rights reserved.
//

#import "SecondViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface SecondViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong)WKWebView *webView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
       self.tabBarController.tabBar.tintColor = [UIColor redColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"js_oc.js" ofType:@"txt"];
    NSString *js = [[NSString alloc] initWithContentsOfFile:path ];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//     根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addUserScript:script];
    config.preferences.javaScriptEnabled = YES;
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
//    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds   ];

    
//     [self.webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.yintai.com/sales/ActivitiesTemplate?pageid=30000322"]]] ;
    [self.webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]] ;


    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:self.webView];
    
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
  
    
    
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"load page error "  );
  
}
//这个代理是服务器redirect时调用

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{


}
//



/**这个代理方法表示当客户端收到服务器的响应头，根据response相关信息，可以决定这次跳转是否可以继续进行。
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
//    if ([navigationResponse.response.URL.host.lowercaseString hasPrefix:@"m.yintai.com"]) {
    
        // 允许跳转
        decisionHandler(WKNavigationResponsePolicyAllow);
//        return;
//    }
    // 不允许跳转
//    decisionHandler(WKNavigationResponsePolicyCancel);
}
/** //根据webView、navigationAction相关信息决定这次跳转是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 如果请求的是百度地址，则延迟5s以后跳转
//    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"m.yintai.com"]) {
    
        //        // 延迟5s之后跳转
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        //            // 允许跳转
        //            decisionHandler(WKNavigationActionPolicyAllow);
        //        });
        
        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
//        return;
//    }
    // 不允许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
    
}
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] show];
    
    NSLog(@"runJavaScriptAlertPanelWithMessage------%@",message);
 
    
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
    
}

// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"%@", message);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
