//
//  MGUtils.m
//  MG
//
//  Created by Enric Enrich on 12/09/15.
//
//

#import "MGUtils.h"

@implementation MGUtils

NSString *pathForResource(NSString *resourcePath)
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSMutableArray *directoryParts = [NSMutableArray arrayWithArray:[resourcePath componentsSeparatedByString:@"/"]];
    NSString *filename = [directoryParts lastObject];
    
    [directoryParts removeLastObject];
    
    NSString *directoryStr = [NSString stringWithFormat:@"%@/%@", kStartFolder, [directoryParts componentsJoinedByString:@"/"]];
    
    return [mainBundle pathForResource:filename ofType:@"" inDirectory:directoryStr];
}

@end
