//
//  STPlayer.h
//  STSourceCodeProject
//
//  Created by qcraft on 2022/5/16.
//  Copyright © 2022 qcraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STPlayer : NSObject

- (instancetype)initWithURL:(NSURL *)URL contentView:(UIView *)contentView;

@property (nonatomic, strong)AVPlayer *player;
@property (nonatomic, strong)AVPlayerItem *playerItem;
@property (nonatomic, strong)AVPlayerLayer *playerLayer;

@end

NS_ASSUME_NONNULL_END
