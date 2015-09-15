//
//  BlogViewModel.m
//  Ghost
//
//  Created by Enric Enrich on 15/09/15.
//
//

#import "BlogViewModel.h"

@interface BlogViewModel ()

@property (nonatomic, strong) NSDictionary *blogInfo;

@end

@implementation BlogViewModel

- (instancetype)initWithBlogInfo:(NSDictionary *)blogInfo
{
    self = [super init];
    
    if (self) {
        self.blogInfo = blogInfo;
    }
    
    return self;
}

#pragma mark - Public

- (NSString *)name
{
    return self.blogInfo[UserDefaultsBlogNameKey];
}

- (NSString *)urlString
{
    return self.blogInfo[UserDefaultsBlogUrlKey];
}

- (NSURL *)url
{
    return [NSURL URLWithString:self.blogInfo[UserDefaultsBlogUrlKey]];
}

@end
