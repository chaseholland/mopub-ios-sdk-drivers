//
//  OpenXBannerCustomEvent.m
//  
//
//  Created by Chase Holland on 8/13/14.
//
//

#import "OpenXBannerCustomEvent.h"

@interface OpenXBannerCustomEvent()

@property(nonatomic, retain) OXMAdBanner* openXbanner;

@end

@implementation OpenXBannerCustomEvent

@synthesize openXbanner;

#pragma -
#pragma mark MPBannerCustomEvent

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
	if (!self.openXbanner)
	{
		self.openXbanner = [[OXMAdBanner alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
		[self.openXbanner setDomain:[info objectForKey:@"domain"]
				   portraitAdUnitID:[info objectForKey:@"portraitAdUnitID"]
				  landscapeAdUnitID:[info objectForKey:@"landscapeAdUnitID"]];
		[self.openXbanner setAdAutoRefresh:NO];
		self.openXbanner.adBannerDelegate = self;
	}
	
	[self.openXbanner.request setCoordinates:self.delegate.location.coordinate];
	
	[self.openXbanner startLoading];
}

#pragma mark -
#pragma mark OpenX Delegate

- (void) adBannerDidLoadAd:(OXMAdBanner *)adBanner
{
	[self.delegate bannerCustomEvent:self didLoadAd:adBanner];
}

- (void) adBanner:(OXMAdBanner *)adBanner didFailToReceiveAdWithError:(NSError *)error
{
	[self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void) adBannerActionWillBegin:(OXMAdBanner *)adBanner willLeaveApplication:(BOOL)willLeave
{
	if (willLeave)
		[self.delegate bannerCustomEventWillLeaveApplication:self];
	else
		[self.delegate bannerCustomEventWillBeginAction:self];
}

- (void) adBannerActionDidBegin:(OXMAdBanner *)adBanner
{
	// Not used by MoPub currently
}

- (void) adBannerActionDidFinish:(OXMAdBanner *)adBanner
{
	[self.delegate bannerCustomEventDidFinishAction:self];
}

- (void) adBannerActionUnableToBegin:(OXMAdBanner *)adBanner
{
	
}

@end
