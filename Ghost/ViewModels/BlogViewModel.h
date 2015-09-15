//
//  BlogViewModel.h
//  Ghost
//
//  Created by Enric Enrich on 15/09/15.
//
//

#import <Foundation/Foundation.h>

@interface BlogViewModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithBlogInfo:(NSDictionary *)blogInfo;

@end
