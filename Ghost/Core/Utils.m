//
//  Utils.m
//  Ghost
//
//  Created by Enric Enrich on 12/09/15.
//
//

#import "Utils.h"

@implementation Utils

+ (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

+ (NSArray *)blogs
{
    return [[self userDefaults] arrayForKey:kBlogs];
}

@end
