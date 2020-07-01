//
//  GTDetailViewController.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/13.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "GTDetailViewController.h"
#import "WebKit/webkit.h"

@interface GTDetailViewController ()<WKNavigationDelegate>

@property(nonatomic, strong) WKWebView* webView;
@property(nonatomic, strong) UIProgressView* progressView;
@property(nonatomic, copy) NSString* urlString;

@end

@implementation GTDetailViewController

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithUrlString:(NSString*)urlString
{
    self = [super init];
    if (self) {
        self.urlString = urlString;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - delegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"webview finish");
}

#pragma mark - action

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.progressView.progress = self.webView.estimatedProgress;
}

#pragma mark - Getters
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = ({
            WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height - 88)];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
            webView.navigationDelegate = self;
            webView;
        });
    }
    return _webView;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = ({
            UIProgressView* progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, 20)];
            progressView;
        });
    }
    return _progressView;
}

@end
