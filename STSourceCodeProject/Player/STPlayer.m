//
//  STPlayer.m
//  STSourceCodeProject
//
//  Created by qcraft on 2022/5/16.
//  Copyright © 2022 qcraft. All rights reserved.
//

#import "STPlayer.h"

@interface STPlayer()

@property (nonatomic, weak)UIView *contentView;

@end

@implementation STPlayer

- (instancetype)init {
    if (self = [super init]) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL contentView:(UIView *)contentView {
    if (self = [super init]) {
        self.contentView = contentView;
        self.playerItem = [[AVPlayerItem alloc]initWithURL:URL];
        self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
        [self.player play];
        [self playRoop];
//        [self showPlayerView];
        
    }
    return self;
}

- (void)playRoop {
    [[NSNotificationCenter defaultCenter]addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        CMTime time = CMTimeMake(0, 1000);
        [self.player seekToTime: time];
        [self.player play];
    }];
    
//    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        self.playerLayer.player = nil;
////        [self.playerLayer removeFromSuperlayer];
////        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
////        [audioSession setActive:YES error:nil];
////        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
//    }];
//
//    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        self.playerLayer.player = self.player;
////        [self showPlayerView];
////        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//////        [audioSession setCategory:AVAudioSessionModeDefault error:nil];
////        [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
//    }];
}

- (void)showPlayerView {
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.contentView.bounds;
    self.playerLayer.contentsGravity = AVLayerVideoGravityResizeAspectFill;
    [self.contentView.layer addSublayer:self.playerLayer];
}

@end
