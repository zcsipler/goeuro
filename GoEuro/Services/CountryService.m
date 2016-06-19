//
//  CountryService.m
//  GoEuro
//
//  Created by Zoltan Csipler on 18/06/16.
//  Copyright © 2016 Zoltan Csipler. All rights reserved.
//

#import "CountryService.h"

#import "GECountry.h"
#import "MTLJSONAdapter.h"

static NSString * const COUNTRY_SEARCH_URL = @"https://api.goeuro.com/api/v2/position/suggest/en/";

@implementation CountryService

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (void)getCountryNamesWithKeyword:(NSString *)keyword resultBlock:(IGetCountries)resultBlock
{
    __block NSDictionary *json;
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *countrySearchUrl = [self createCountrySearchUrlWithKeyword:keyword];
    [[session dataTaskWithURL:[NSURL URLWithString:countrySearchUrl]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          if (data)
          {
              json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              NSArray *countryList = [self parseCountryListFromJSON:json];
              NSArray *countryNames = [self createCountryNamesList:countryList];
              dispatch_async(dispatch_get_main_queue(), ^{
                  resultBlock(countryNames);
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  resultBlock(nil);
              });
          }
      }] resume];
}

- (NSArray *)parseCountryListFromJSON:(id)json
{
    NSError *JSONerror = nil;
    NSMutableArray *countryList = [[NSMutableArray alloc] init];
    
    @try
    {
        for (NSDictionary *dictionary in json)
        {
            GECountry *country = [MTLJSONAdapter modelOfClass:GECountry.class fromJSONDictionary:dictionary error:&JSONerror];
            [countryList addObject:country];
        }
    }
    @catch (NSException *exception)
    {
        return nil;
    }
    
    NSArray *sortedCountyList = [self orderCountriesByDistance:countryList];
    return sortedCountyList;
}

- (NSArray *)createCountryNamesList:(NSArray *)countryList
{
    NSMutableArray *countryNames = [[NSMutableArray alloc] init];
    for (GECountry *country in countryList)
    {
        if (country.name)
        {
            [countryNames addObject:country.name];
        }
    }
    
    return countryNames;
}

- (NSString *)createCountrySearchUrlWithKeyword:(NSString *)keyword
{
    keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [COUNTRY_SEARCH_URL stringByAppendingString:keyword];
}

- (NSArray *)orderCountriesByDistance:(NSArray *)countryList
{
    for (GECountry *country in countryList)
    {
        float currentLatitude = self.locationManager.location.coordinate.latitude;
        float currentLongitude = self.locationManager.location.coordinate.longitude;
        
        float dLatitude = fabs((currentLatitude - country.geoPosition.latitude));
        float dLongitude =  fabs((currentLongitude - country.geoPosition.longitude));
        float distance = dLatitude*dLatitude + dLongitude*dLongitude;
        
        country.distance = [NSNumber numberWithFloat:distance];
    }
    
    NSArray *sortedCountryList = [countryList sortedArrayUsingSelector:@selector(compare:)];
    return sortedCountryList;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Location Status : %d", status);
}

@end
