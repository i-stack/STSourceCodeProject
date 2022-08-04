# NSTimer

目录：

一、[NSTimer的创建方式](#NSTimer的创建方式)

二、[NSTimer常见问题](#NSTimer常见问题)

三、[NSTimer解决方案](#NSTimer解决方案)

## NSTimer的创建方式

### oc版本

```objectivec

// 方式一

self.delayTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(handleHideTimer) userInfo:nil repeats:YES];
[[NSRunLoop currentRunLoop] addTimer:self.delayTimer forMode:NSRunLoopCommonModes];

self.delayTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
    NSLog(@"handleHideTimer");
}];
[[NSRunLoop currentRunLoop] addTimer:self.delayTimer forMode:NSRunLoopCommonModes];

// 方式二

NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleHideTimer) userInfo:nil repeats:YES];
self.delayTimer = timer;
    
NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
    NSLog(@"handleHideTimer");
}];
self.delayTimer = timer;

```
### swift版本

```swift

// 方式一
let timer = Timer.init(timeInterval: 1, target: self, selector: #selector(handleHideTimer), userInfo: nil, repeats: true)
RunLoop.current.add(timer, forMode: .common)
self.delayTimer = timer
        
let timer = Timer.init(timeInterval: 1, repeats: true) { timer in
    STLog("handleHideTimer")
}
RunLoop.current.add(timer, forMode: .common)
self.delayTimer = timer

// 方式二

let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleHideTimer), userInfo: nil, repeats: true)
delayTimer = timer
        
let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
     STLog("handleHideTimer")
}
self.delayTimer = timer
```


## NSTimer常见问题

## NSTimer解决方案
