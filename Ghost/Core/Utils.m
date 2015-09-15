//
//  Utils.m
//  Ghost
//
//  Created by Enric Enrich on 12/09/15.
//
//

#import "Utils.h"

@implementation Utils

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[NSApp delegate];
}

+ (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

+ (NSArray *)blogs
{
    return [[self userDefaults] arrayForKey:UserDefaultsBlogsKey];
}

@end
