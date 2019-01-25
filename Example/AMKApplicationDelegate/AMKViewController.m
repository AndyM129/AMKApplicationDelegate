//
//  AMKViewController.m
//  AMKApplicationDelegate
//
//  Created by mengxinxin on 05/03/2018.
//  Copyright (c) 2018 mengxinxin. All rights reserved.
//

#import "AMKViewController.h"

@interface AMKViewController ()
@property(nonatomic, strong) UIWebView *webView;
@end

@implementation AMKViewController

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = [NSString stringWithFormat:@"AMKApplicationDelegate 瘦身示例"];
    }
    return self;
}

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/AndyM129/AMKApplicationDelegate"]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Properties

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
    }
    return _webView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
