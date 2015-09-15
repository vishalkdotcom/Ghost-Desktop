//
//  BlogViewModel.h
//  Ghost
//
//  Created by Enric Enrich on 15/09/15.
//
//

#import <Foundation/Foundation.h>

@interface BlogViewModel : NSObject

- (instancetype)initWithBlogInfo:(NSDictionary *)blogInfo;

- (NSString *)name;
- (NSString *)urlString;
- (NSURL *)url;

@end
