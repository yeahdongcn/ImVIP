//
//  RSMapViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/14/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSMapViewController.h"

#import "RSAppDelegate.h"

#import "RSPOIView.h"

#import "SFUIViewMacroses.h"

#import <BMapKit.h>

#import <UIViewController+KNSemiModal.h>

#import <objc/runtime.h>

@interface RSMapViewController () <BMKMapViewDelegate, BMKSearchDelegate>

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, weak) IBOutlet BMKMapView *mapView;

@property (nonatomic, strong) BMKSearch *mapSearch;

@property (nonatomic) BOOL isLoadAtFirstTime;

@property (nonatomic) BOOL needReload;

@property (nonatomic) BOOL isViewAppear;

@property (nonatomic) NSUInteger indexOfCard;

@property (nonatomic) NSInteger radius;

@property (nonatomic, strong) NSMutableDictionary *poiInfoMap;

@end

@implementation RSMapViewController

- (void)__resetSearch
{
    self.indexOfCard = -1;
}

- (void)__doSearch
{
    self.indexOfCard++;
    
    BmobObject *card = [DataCenter getCachedCardAtIndex:self.indexOfCard];
    [self.mapSearch poiSearchNearBy:[card objectForKey:@"title"]
                             center:self.mapView.userLocation.location.coordinate
                             radius:self.radius
                          pageIndex:0];
}

- (void)__reload
{
    self.needReload = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.poiInfoMap removeAllObjects];
    
    [DataCenter getCardsAsyncWithCallback:^(NSArray *cards) {
        [self __resetSearch];
        [self __doSearch];
    } whetherNeedQuery:NO];
}

- (void)__cardsWillArrive:(NSNotification *)notification
{
    // Nothing to do currently
}

- (void)__cardsDidArrive:(NSNotification *)notification
{
    if (self.isViewAppear) {
        [self __reload];
    } else {
        self.needReload = YES;
    }
}

#pragma mark - NSObjet

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__cardsWillArrive:) name:RSDataCenterCardsWillArrive object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__cardsDidArrive:) name:RSDataCenterCardsDidArrive object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isLoadAtFirstTime = YES;
    self.radius = 1000;
    
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setShowMapScaleBar:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.isViewAppear = YES;
    
    if (self.needReload) {
        [self __reload];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.isViewAppear = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
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

- (NSMutableDictionary *)poiInfoMap
{
    if (!_poiInfoMap) {
        _poiInfoMap = [[NSMutableDictionary alloc] init];
    }
    return _poiInfoMap;
}

#pragma mark - BMKMapViewDelegate

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    if (self.isLoadAtFirstTime) {
        self.isLoadAtFirstTime = NO;
        
        [mapView setRegion:BMKCoordinateRegionMakeWithDistance(userLocation.coordinate, self.radius, self.radius) animated:YES];
        
        [DataCenter getCardsAsyncWithCallback:^(NSArray *cards) {
            [self __resetSearch];
            [self __doSearch];
        } whetherNeedQuery:NO];
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

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    RSPOIView *poiView = (RSPOIView *)[[[NSBundle mainBundle] loadNibNamed:@"RSPOIView" owner:nil options:nil] firstObject];
    poiView.autoresizingMask = UIViewAutoresizingMake(@"W+H");
    BMKPoiInfo *info = (self.poiInfoMap)[objc_getAssociatedObject(view.annotation, @"uid")];
    poiView.nameLabel.text = info.name;
    poiView.addressLabel.text = info.address;
    [poiView.phoneButton setTitle:info.phone forState:UIControlStateNormal];
    [self presentSemiView:poiView withOptions:@{
                                                KNSemiModalOptionKeys.shadowRadius  : @(2.0),
                                                KNSemiModalOptionKeys.shadowOpacity : @(0.2),
                                                KNSemiModalOptionKeys.shadowOffset  : [NSValue valueWithCGSize:CGSizeZero],
                                                }];
}

#pragma mark - BMKSearchDelegate

- (void)onGetPoiResult:(NSArray *)poiResultList searchType:(int)type errorCode:(int)error
{
    for (BMKPoiResult *result in poiResultList) {
        for (BMKPoiInfo *info in result.poiInfoList) {
            (self.poiInfoMap)[info.uid] = info;
            
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
            objc_setAssociatedObject(annotation, @"uid", info.uid, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            annotation.title = info.name;
            annotation.coordinate = info.pt;
            [self.mapView addAnnotation:annotation];
        }
    }
    if (self.indexOfCard < ([DataCenter numberOfCachedCard] - 1)) {
        [self __doSearch];
    }
}

@end
