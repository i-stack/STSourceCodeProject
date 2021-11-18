//
//  STWebViewViewController.m
//  STInterViewProject
//
//  Created by song on 2021/11/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface STWebViewViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (retain, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation STWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.infoq.cn/article/jqzxgcc15zjwv7iw9ihh"]]];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    WKSnapshotConfiguration *snapshotConfig = [[WKSnapshotConfiguration alloc]init];
    snapshotConfig.rect = _webView.frame;
    [_webView takeSnapshotWithConfiguration:snapshotConfig completionHandler:^(UIImage * _Nullable snapshotImage, NSError * _Nullable error) {
            
    }];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)dealloc {
    [_webView release];
    [super dealloc];
}
@end
