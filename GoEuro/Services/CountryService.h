//
//  CountryService.h
//  GoEuro
//
//  Created by Zoltan Csipler on 18/06/16.
//  Copyright © 2016 Zoltan Csipler. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

typedef void(^IGetCountries)(NSArray *countryList);

@interface CountryService : NSObject <CLLocationManagerDelegate>

@property (nonatomic,retain) CLLocationManager *locationManager;

- (void)getCountryNamesWithKeyword:(NSString *)keyword resultBlock:(IGetCountries)resultBlock;

@end
