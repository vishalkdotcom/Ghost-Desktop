//
//  Utils.h
//  Ghost
//
//  Created by Enric Enrich on 12/09/15.
//
//

#import <Foundation/Foundation.h>

@class AppDelegate;

@interface Utils : NSObject

+ (AppDelegate *)appDelegate;
+ (NSUserDefaults *)userDefaults;
+ (NSArray *)blogs;

@end
