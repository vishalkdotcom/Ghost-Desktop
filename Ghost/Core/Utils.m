//
//  Utils.m
//  Ghost
//
//  Created by Enric Enrich on 12/09/15.
//
//

#import "Utils.h"
#import "BlogViewModel.h"

@implementation Utils

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[NSApp delegate];
}

+ (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

+ (NSArray *)unarchivedBlogs
{
    return [[self userDefaults] arrayForKey:UserDefaultsBlogsKey];
}

+ (NSArray *)blogs
{
    NSMutableArray *blogs = [NSMutableArray new];
    
    for (NSData *blogData in [[self userDefaults] arrayForKey:UserDefaultsBlogsKey]) {
        [blogs addObject:[NSKeyedUnarchiver unarchiveObjectWithData:blogData]];
    }
    
    return blogs;
}

@end
