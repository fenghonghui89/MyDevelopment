
## 安装、更新：
sudo gem install cocoapods

pod install --verbose --no-repo-update
pod update --verbose --no-repo-update


## 使用
- 进入项目根目录，创建Podfile文件：touch Podfile
- 编辑Podfile

```
platform :ios
pod 'Reachability',  '~> 3.0.0'
pod 'SBJson', '~> 4.0.0'

platform :ios, '7.0'
pod 'AFNetworking', '~> 2.0'
```

- 进入项目根目录，执行导入命令：pod install
