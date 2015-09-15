//
//  BlogViewController.h
//  Ghost
//
//  Created by Enric Enrich on 14/09/15.
//
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface BlogViewController : NSViewController

- (instancetype)initWithUrl:(NSURL *)url;

@property (nonatomic, strong) WebView *webView;
@property (nonatomic, strong) NSURL *url;

@end
