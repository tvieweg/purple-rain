//
//  Datasource.m
//  Purple Rain
//
//  Created by Trevor Vieweg on 4/22/16.
//  Copyright © 2016 Trevor Vieweg. All rights reserved.
//

#import "Datasource.h"
#import "YQL.h"

const float kDistanceThreshold = 1000;

@interface Datasource () <CLLocationManagerDelegate> {
    NSMutableArray *_favoriteLocations;
    CLLocation *_currentLocation;
}

@end

@implementation Datasource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self startLocationManager];
        [self getLocalWeather];
    }
    
    return self;
}

- (void)startLocationManager {
    
    // Create the location manager if this object does not
    // already have one.
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        
    }
    
    //Always active needed for notifications. Uncomment to authorize local notifications
    //[self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = kDistanceThreshold; // meters
    
    [self.locationManager startUpdatingLocation];

}

- (void)getLocalWeather {
    YQL *yql = [[YQL alloc] init];
    NSString *queryString = @"select wind from weather.forecast where woeid=2460286";
    NSDictionary *results = [yql query:queryString];
    NSLog(@"%@",results[@"query"][@"count"]);
    NSLog(@"%@",results[@"query"][@"results"]);
}

@end
