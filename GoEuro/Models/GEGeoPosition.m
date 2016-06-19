//
//  GEGeoPosition.m
//  GoEuro
//
//  Created by Zoltan Csipler on 17/06/16.
//  Copyright © 2016 Zoltan Csipler. All rights reserved.
//

#import "GEGeoPosition.h"

@implementation GEGeoPosition

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"latitude": @"latitude",
             @"longitude": @"longitude",
             };
}

@end
