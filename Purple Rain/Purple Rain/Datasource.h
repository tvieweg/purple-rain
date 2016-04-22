//
//  Datasource.h
//  Purple Rain
//
//  Created by Trevor Vieweg on 4/22/16.
//  Copyright © 2016 Trevor Vieweg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Datasource : NSObject

@property (strong, nonatomic) CLLocationManager *locationManager;

+(instancetype) sharedInstance;

@end
