//
//  UZ_AdHubSDK.m
//  UZModule
//
//  Created by kenny on 14-3-5.
//  Copyright (c) 2014年 APICloud. All rights reserved.
//

#import "UZ_AdHubSDK.h"
#import "UZAppDelegate.h"
#import "NSDictionaryUtils.h"
#import <AdHubSDK/AdHubSDK.h>

@interface UZ_AdHubSDK ()<AdHubBannerViewDelegate, AdHubInterstitialDelegate, AdHubSplashDelegate, AdHubCustomViewDelegate, AdHubRewardBasedVideoAdDelegate, AdHubNativeDelegate>
{
    NSInteger _splashCbID;
}

@property (nonatomic,strong)AdHubBannerView *banner;
@property (nonatomic,strong)AdHubInterstitial *interstitial;
@property (nonatomic,strong)AdHubSplash *splash;
@property (nonatomic,strong)UIView *customSplashView;
@property (nonatomic,strong)AdHubCustomView *custom;
@property (nonatomic,strong)AdHubNative *native;

@property (nonatomic,strong)NSDictionary *paramDic;
@property (nonatomic,strong)NSMutableArray *saveNativeDatas;

@end

@implementation UZ_AdHubSDK

- (id)initWithUZWebView:(UZWebView *)webView_
{
    if (self = [super initWithUZWebView:webView_]) {
        
    }
    return self;
}

- (void)dispose
{
    
}

- (NSString *)registAdMessage:(NSDictionary *)paramDic
{
    NSString *spaceID = [paramDic stringValueForKey:@"spaceID" defaultValue:@""];
    NSString *appID = [paramDic stringValueForKey:@"appID" defaultValue:@""];
    [AdHubSDKManager configureWithApplicationID:appID];
    return spaceID;
}

#pragma mark - Splash ad
- (void)showSplashAd:(NSDictionary *)paramDic
{
    self.customSplashView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:self.customSplashView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.customSplashView];
    NSString *spaceID = [self registAdMessage:paramDic];
    _splash = [[AdHubSplash alloc] initWithSpaceID:spaceID spaceParam:@""];
    _splash.delegate = self;
    [_splash loadAndDisplayUsingContainerView:self.customSplashView];
}

- (UIViewController *)adSplashViewControllerForPresentingModalView
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)splashDidReceiveAd:(AdHubSplash *)ad
{
    [self sendResultEventWithCallbackId:0 dataString:@"开屏广告请求成功" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)splash:(AdHubSplash *)ad didFailToLoadAdWithError:(AdHubRequestError *)error
{
    [self splashClean];
    [self sendResultEventWithCallbackId:0 dataString:@"开屏广告请求失败" stringType:kUZStringType_TEXT errDict:@{@"requestError " : error} doDelete:YES];
}

- (void)splashDidDismissScreen:(AdHubSplash *)ad
{
    [self splashClean];
    [self sendResultEventWithCallbackId:0 dataString:@"开屏广告已经消失" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)splashDidClick:(NSString *)landingPageURL
{
    [_splash splashCloseAd];
    [self sendResultEventWithCallbackId:0 dataString:@"开屏广告被点击" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)splashDidPresentScreen:(AdHubSplash *)ad
{
    [self sendResultEventWithCallbackId:0 dataString:@"开屏广告已经呈现" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)splashClean
{
    self.splash.delegate = nil;
    self.splash = nil;
    [self.customSplashView removeFromSuperview];
    self.customSplashView = nil;
}
            
#pragma mark - BannerView Ad
- (void)showBannerAd:(NSDictionary *)paramDic
{
    self.paramDic = paramDic;
    NSString *spaceID = [self registAdMessage:paramDic];
    self.banner = [[AdHubBannerView alloc] initWithSpaceID:spaceID spaceParam:@""];
    self.banner.delegate = self;
    [self.banner loadAd];
}

- (UIViewController *)adBannerViewControllerForPresentingModalView
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)adViewDidReceiveAd:(AdHubBannerView *)bannerView
{
    CGFloat orginX = [self.paramDic floatValueForKey:@"centerX" defaultValue:bannerView.frame.origin.x];
    CGFloat orginY = [self.paramDic floatValueForKey:@"centerY" defaultValue:bannerView.frame.origin.y];
    CGFloat width = [self.paramDic floatValueForKey:@"w" defaultValue:bannerView.frame.size.width];
    CGFloat heigth = [self.paramDic floatValueForKey:@"h" defaultValue:bannerView.frame.size.height];
    bannerView.frame = CGRectMake(orginX, orginY, width, heigth);
    NSString *superViewName = [self.paramDic stringValueForKey:@"fixedOn" defaultValue:nil];
    BOOL fix = [self.paramDic boolValueForKey:@"fixed" defaultValue:YES];
    [self addSubview:bannerView fixedOn:superViewName fixed:fix];
    [self sendResultEventWithCallbackId:0 dataString:@"Banner 广告请求成功" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)adViewDidDismissScreen:(AdHubBannerView *)bannerView
{
    [self sendResultEventWithCallbackId:0 dataString:@"Banner 广告已经消失" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)adView:(AdHubBannerView *)bannerView didFailToReceiveAdWithError:(AdHubRequestError *)error
{
    [self.banner removeFromSuperview];
    self.banner = nil;
    [self sendResultEventWithCallbackId:0 dataString:@"Banner 广告请求失败" stringType:kUZStringType_TEXT errDict:@{@"requestError " : error} doDelete:YES];
}

- (void)adViewClicked:(NSString *)landingPageURL
{
    [self.banner removeFromSuperview];
    self.banner = nil;
    [self sendResultEventWithCallbackId:0 dataString:@"Banner 广告被点击" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)closeBannerAd:(NSDictionary *)paramDic
{
    [self.banner bannerCloseAd];
}

#pragma mark - Interstitial Ad
- (void)showInsertAd:(NSDictionary *)paramDic
{
    self.paramDic = paramDic;
    NSString *spaceID = [self registAdMessage:paramDic];
    self.interstitial = [[AdHubInterstitial alloc] initWithSpaceID:spaceID spaceParam:@""];
    self.interstitial.delegate = self;
    self.interstitial.needAnimation = NO;
    [self.interstitial loadAd];
}

- (void)interstitialDidReceiveAd:(AdHubInterstitial *)ad
{
    [self sendResultEventWithCallbackId:0 dataString:@"Interstitial 广告请求成功" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
    [self.interstitial presentFromRootViewController:[self adBannerViewControllerForPresentingModalView]];
}

- (void)interstitialDidFailToPresentScreen:(AdHubInterstitial *)ad
{
    [self sendResultEventWithCallbackId:0 dataString:@"Interstitial 广告展示失败" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)interstitial:(AdHubInterstitial *)ad didFailToReceiveAdWithError:(AdHubRequestError *)error
{
    [self sendResultEventWithCallbackId:0 dataString:@"Interstitial 广告请求失败" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)interstitialDidClick:(NSString *)landingPageURL
{
    [self sendResultEventWithCallbackId:0 dataString:@"Interstitial 广告被点击" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

#pragma mark - CustomView Ad
- (void)showCustomAd:(NSDictionary *)paramDic
{
    self.paramDic = paramDic;
    NSString *spaceID = [self registAdMessage:paramDic];
    self.custom = [[AdHubCustomView alloc] initWithSpaceID:spaceID spaceParam:@""];
    self.custom.delegate = self;
    [self.custom loadAd];
}

- (UIViewController *)adCustomViewControllerForPresentingModalView
{
    return [self adBannerViewControllerForPresentingModalView];
}

- (void)adCustomViewDidReceiveAd:(AdHubCustomView *)customView
{
    CGFloat orginX = [self.paramDic floatValueForKey:@"centerX" defaultValue:customView.frame.origin.x];
    CGFloat orginY = [self.paramDic floatValueForKey:@"centerY" defaultValue:customView.frame.origin.y];
    CGFloat width = [self.paramDic floatValueForKey:@"w" defaultValue:customView.frame.size.width];
    CGFloat heigth = [self.paramDic floatValueForKey:@"h" defaultValue:customView.frame.size.height];
    customView.frame = CGRectMake(orginX, orginY, width, heigth);
    NSString *superViewName = [self.paramDic stringValueForKey:@"fixedOn" defaultValue:nil];
    BOOL fix = [self.paramDic boolValueForKey:@"fixed" defaultValue:YES];
    [self addSubview:customView fixedOn:superViewName fixed:fix];
    [self sendResultEventWithCallbackId:0 dataString:@"CustomView 广告请求成功" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)adCustomViewDidDismissScreen:(AdHubCustomView *)customView
{
    _custom = nil;
    [self sendResultEventWithCallbackId:0 dataString:@"CustomView 广告已经消失" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)adCustomView:(AdHubCustomView *)customView didFailToReceiveAdWithError:(AdHubRequestError *)error
{
    _custom = nil;
    [self sendResultEventWithCallbackId:0 dataString:@"CustomView 广告请求失败" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)customDidClick:(NSString *)landingPageURL
{
    [self sendResultEventWithCallbackId:0 dataString:@"CustomView 广告被点击" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
    if (!landingPageURL.length) {
        [self.customSplashView removeFromSuperview];
        self.customSplashView = nil;
    }
}

- (void)closeCustomAd:(NSDictionary *)paramDic
{
    [self.custom customCloseAd];
}

#pragma mark - RewardVideo Ad
- (void)showRewardVideoAd:(NSDictionary *)paramDic
{
    [AdHubRewardBasedVideoAd sharedInstance].delegate = self;
    self.paramDic = paramDic;
    NSString *spaceID = [self registAdMessage:paramDic];
    [[AdHubRewardBasedVideoAd sharedInstance] loadAdWithSpaceID:spaceID spaceParam:@""];
}

- (UIViewController *)adRewardViewControllerForPresentingModalView
{
    return [self adBannerViewControllerForPresentingModalView];
}

- (void)rewardBasedVideoAdDidReceiveAd:(AdHubRewardBasedVideoAd *)rewardBasedVideoAd
{
    [self sendResultEventWithCallbackId:0 dataString:@"rewardBasedVideo 广告请求成功" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
   [[AdHubRewardBasedVideoAd sharedInstance] presentFromRootViewController:[self adBannerViewControllerForPresentingModalView]];
}

- (void)rewardBasedVideoAd:(AdHubRewardBasedVideoAd *)rewardBasedVideoAd didRewardUserWithReward:(NSObject *)reward
{
    [self sendResultEventWithCallbackId:0 dataString:@"rewardBasedVideo 得到奖励" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"得到奖励" message:(NSString *)reward preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
    }]];
    [[self adBannerViewControllerForPresentingModalView] presentViewController:alertController animated:YES completion:NULL];
}

- (void)rewardBasedVideoAd:(AdHubRewardBasedVideoAd *)rewardBasedVideoAd didFailToLoadWithError:(AdHubRequestError *)error
{
    [self sendResultEventWithCallbackId:0 dataString:@"rewardBasedVideo 广告请求失败" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

#pragma mark - Native ad
- (void)showNativeAd:(NSDictionary *)paramDic
{
    self.paramDic = paramDic;
    NSString *spaceID = [self registAdMessage:paramDic];
    self.native = [[AdHubNative alloc] initWithSpaceID:spaceID spaceParam:@""];
    self.native.delegate = self;
    self.native.sdkOpenAdClickUrl = [paramDic boolValueForKey:@"" defaultValue:YES];
    [self.native loadAd];
}

- (void)nativeDidLoaded:(AdHubNative *)ad
{
    AdHubNativeAdDataModel *dataModel = ad.adDataModels[0];
    [self.saveNativeDatas addObject:dataModel];
    [self nativeShowExposeLog:dataModel];
    [self sendResultEventWithCallbackId:0 dataString:dataModel.jsonString stringType:kUZStringType_JSON errDict:nil doDelete:YES];
}

- (void)nativeDidClick:(NSString *)tipMessage
{
//    AdHubNativeAdDataModel *dataModel = self.native.adDataModels[0];
//    [self nativeClickExposeLog:dataModel];
    [self sendResultEventWithCallbackId:0 dataString:@"Native 广告被点击" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (void)native:(AdHubNative *)ad didFailToLoadAdWithError:(AdHubRequestError *)error
{
    self.native = nil;
    [self sendResultEventWithCallbackId:0 dataString:@"Native 广告请求失败" stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
}

- (UIView *)adNativeShowView
{
    return nil;
}

- (UIViewController *)adNativeViewControllerForPresentingAdDetail
{
    return [self adBannerViewControllerForPresentingModalView];
}

- (void)nativeShowExposeLog:(AdHubNativeAdDataModel *)dataModel
{
    [self.native didShowAdDataModel:dataModel];
}

//- (void)nativeClickExposeLog:(AdHubNativeAdDataModel *)dataModel
//{
//    [self.native didClickAdDataModel:dataModel];
//}

- (void)sendTracker:(NSDictionary *)paramDic
{
    NSInteger index = [paramDic intValueForKey:@"index" defaultValue:0];
    if (index < self.saveNativeDatas.count && index >= 0) {
        AdHubNativeAdDataModel *dataModel = self.saveNativeDatas[index];
        [self.native didClickAdDataModel:dataModel];
    }
}

- (NSMutableArray *)saveNativeDatas
{
    if (!_saveNativeDatas) {
        _saveNativeDatas = [NSMutableArray array];
    }
    return _saveNativeDatas;
}

@end

