//
//  RSMapViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/14/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSMapViewController.h"

#import "RSAppDelegate.h"

#import <BMapKit.h>

@interface RSMapViewController () <BMKMapViewDelegate, BMKSearchDelegate>

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, weak) IBOutlet BMKMapView *mapView;

@property (nonatomic, strong) BMKSearch *mapSearch;

@property (nonatomic) BOOL isFirstTimeLoaded;

@property (nonatomic) NSUInteger indexOfCard;

@property (nonatomic) NSInteger radius;

@end

@implementation RSMapViewController

- (void)__resetSearch
{
    self.indexOfCard = -1;
}

- (void)__doSearch
{
    self.indexOfCard++;
    
    BmobObject *card = [DataCenter cardAtIndex:self.indexOfCard];
    [self.mapSearch poiSearchNearBy:[card objectForKey:@"title"]
                             center:self.mapView.userLocation.location.coordinate
                             radius:self.radius
                          pageIndex:0];
}

#pragma mark - NSObjet

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isFirstTimeLoaded = YES;
    self.radius = 1000;
    
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setShowMapScaleBar:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = YES;
}

#pragma mark - RSMapViewController

- (BMKSearch *)mapSearch
{
    if (!_mapSearch) {
        _mapSearch = [[BMKSearch alloc] init];
        [_mapSearch setDelegate:self];
    }
    return _mapSearch;
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    if (self.isFirstTimeLoaded) {
        self.isFirstTimeLoaded = NO;
        
        [mapView setRegion:BMKCoordinateRegionMakeWithDistance(userLocation.coordinate, self.radius, self.radius) animated:YES];
        
        [DataCenter queryCards:NO withCallback:^(NSArray *cards) {
            [self __resetSearch];
            [self __doSearch];
        }];
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        annotationView.pinColor = BMKPinAnnotationColorRed;
        annotationView.animatesDrop = YES;
        return annotationView;
    }
    return nil;
}

#pragma mark - BMKSearchDelegate

- (void)onGetPoiResult:(NSArray *)poiResultList searchType:(int)type errorCode:(int)error
{
    for (BMKPoiResult *result in poiResultList) {
        for (BMKPoiInfo *info in result.poiInfoList) {
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
            annotation.title = info.name;
            annotation.coordinate = info.pt;
            [self.mapView addAnnotation:annotation];
        }
    }
    if (self.indexOfCard < (DataCenter.cards.count - 1)) {
        [self __doSearch];
    }
}

@end
