//
//  OpenXInterstitialCustomEvent.m
//  MemoryMatches
//
//  Created by Chase Holland on 8/13/14.
//
//

#import "OpenXInterstitialCustomEvent.h"

@interface OpenXInterstitialCustomEvent()

@property (nonatomic, retain) OXMAdInterstitialController* openXInterstitial;

@end

@implementation OpenXInterstitialCustomEvent

@synthesize openXInterstitial;

#pragma mark -
#pragma mark MPInterstitialCustomEvent

- (void) requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
	if (!self.openXInterstitial)
	{
		self.openXInterstitial = [[OXMAdInterstitialController alloc] initWithDomain:[info objectForKey:@"domain"]
																	portraitAdUnitID:[info objectForKey:@"portraitAdUnitID"]
																    landscapeAdUnitID:[info objectForKey:@"landscapeAdUnitID"]];
		
		self.openXInterstitial.interstitialDelegate = self;
	}
	
	[self.openXInterstitial.request setCoordinates:self.delegate.location.coordinate];
	
	[self.openXInterstitial loadAd];
}

- (void) showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
	[self.openXInterstitial presentLoadedAd];
}

#pragma mark -
#pragma mark OpenXInterstitialCustomEvent

- (void)interstitial:(OXMAdInterstitialController *)adController didFailToReceiveAdWithError:(NSError *)error
{
	[self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void) interstitialDidBegin:(OXMAdInterstitialController *)adController
{
	[self.delegate interstitialCustomEventDidAppear:self];
}

- (void) interstitialDidFinish:(OXMAdInterstitialController *)adController
{
	[self.delegate interstitialCustomEventDidDisappear:self];
}

- (void) interstitialDidLoad:(OXMAdInterstitialController *)adController
{
	[self.delegate interstitialCustomEvent:self didLoadAd:adController];
}

- (void) interstitialWillLeaveApplication:(OXMAdInterstitialController *)adController
{
	[self.delegate interstitialCustomEventWillLeaveApplication:self];
}

@end
