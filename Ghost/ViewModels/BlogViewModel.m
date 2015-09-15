//
//  BlogViewModel.m
//  Ghost
//
//  Created by Enric Enrich on 15/09/15.
//
//

#import "BlogViewModel.h"

NSString * const BlogViewBlogInfoKey = @"BlogViewBlogInfoKey";

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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        self.blogInfo = [aDecoder decodeObjectForKey:BlogViewBlogInfoKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.blogInfo forKey:BlogViewBlogInfoKey];
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
