# 配置mainfest.plist

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>items</key>
	<array>
		<dict>
			<key>assets</key>
			<array>
				<dict>
					<key>kind</key>
					<string>software-package</string>
					<key>url</key>
          <!-- 存放ipa包的地址 -->
					<string>https://img.qcraftai.com/qpad-app/QPad_App_1.0.ipa</string>
				</dict>
				<dict>
					<key>kind</key>
					<string>display-image</string>
					<key>url</key>
					<string>https://img.qcraftai.com/qpad-app/57.png</string>
				</dict>
				<dict>
					<key>kind</key>
					<string>full-size-image</string>
					<key>url</key>
					<string>https://img.qcraftai.com/qpad-app/512.png</string>
				</dict>
			</array>
			<key>metadata</key>
			<dict>
				<key>bundle-identifier</key>
        <!-- Xcode bundle id -->
				<string>org.reactjs.native.QpadApp</string>
				<key>bundle-version</key>
				<string>1.0</string>
				<key>kind</key>
				<string>software</string>
				<key>platform-identifier</key>
				<string>com.apple.platform.iphoneos</string>
				<key>title</key>
				<string>QpadApp</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>
```
将配置好的mainfest.plist文件存放到服务器，最好和ipa放在一起。

代码访问：itms-services://?action=download-manifest&url=mainfest.plist地址
				
