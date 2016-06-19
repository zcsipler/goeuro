//
//  GECountry.m
//  GoEuro
//
//  Created by Zoltan Csipler on 17/06/16.
//  Copyright © 2016 Zoltan Csipler. All rights reserved.
//

#import "GECountry.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation GECountry

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"_id": @"_id",
             @"countryId": @"countryId",
             @"distance": @"distance",
             @"locationId": @"locationId",
             @"coreCountry": @"coreCountry",
             @"inEurope": @"inEurope",
             @"key": @"key",
             @"name": @"name",
             @"fullName": @"fullName",
             @"iataAirportCode": @"iata_airport_code",
             @"type": @"type",
             @"country": @"country",
             @"countryCode": @"countryCode",
             @"names": @"names",
             @"alternativeNames": @"alternativeNames",
             @"geoPosition": @"geo_position",
             };
}

+ (NSValueTransformer *)geoPositionJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:GEGeoPosition.class];
}

- (NSComparisonResult)compare:(GECountry *)object
{
    if ([self.distance floatValue] < [object.distance floatValue])
    {
        return NSOrderedAscending;
    }
    else if ([self.distance floatValue] > [object.distance floatValue])
    {
        return NSOrderedDescending;
    }
    else
    {
        return NSOrderedSame;
    }
}

@end
