//
//  GEGeoPosition.h
//  GoEuro
//
//  Created by Zoltan Csipler on 17/06/16.
//  Copyright © 2016 Zoltan Csipler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MTLJSONAdapter.h"
#import "MTLModel.h"

@interface GEGeoPosition : MTLModel<MTLJSONSerializing>

@property(nonatomic,assign) CGFloat latitude;
@property(nonatomic,assign) CGFloat longitude;

@end
