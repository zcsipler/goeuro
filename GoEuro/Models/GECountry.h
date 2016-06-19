//
//  GECountry.h
//  GoEuro
//
//  Created by Zoltan Csipler on 17/06/16.
//  Copyright © 2016 Zoltan Csipler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GEGeoPosition.h"
#import "MTLJSONAdapter.h"
#import "MTLModel.h"

@interface GECountry : MTLModel<MTLJSONSerializing>

@property(nonatomic,strong) NSNumber * _id;
@property(nonatomic,strong) NSNumber * countryId;
@property(nonatomic,strong) NSNumber *distance;
@property(nonatomic,strong) NSNumber * locationId;
@property(nonatomic,copy) NSString *key;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *fullName;
@property(nonatomic,copy) NSString *iataAirportCode;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *country;
@property(nonatomic,copy) NSString *countryCode;
@property(nonatomic,copy) NSDictionary *names;
@property(nonatomic,copy) NSDictionary *alternativeNames;
@property(nonatomic,strong) GEGeoPosition *geoPosition;
@property(nonatomic,assign) BOOL coreCountry;
@property(nonatomic,assign) BOOL inEurope;

@end
