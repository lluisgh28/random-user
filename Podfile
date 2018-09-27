use_frameworks!

platform :ios, 10.0

workspace 'RandomUser.xcworkspace'

# Common dependencies versions
$rxSwiftVersion =                     '~> 4.2'

target 'RandomUser' do
  project 'RandomUser.xcodeproj'

  target 'RandomUserTests' do
    project 'RandomUser.xcodeproj'
  end
end

target 'RandomUserDomainKit' do
  project 'RandomUserDomainKit.xcodeproj'

  pod 'RxSwift',                        $rxSwiftVersion

  target 'RandomUserDomainKitTests' do
    project 'RandomUserDomainKit.xcodeproj'
  end
end

target 'RandomUserDataKit' do
  project 'RandomUserDataKit.xcodeproj'

  pod 'RxSwift',                        $rxSwiftVersion
  pod 'RealmSwift',                     '~> 3.10'
  pod 'RxRealm',                        '~> 0.7'

  target 'RandomUserDataKitTests' do
    project 'RandomUserDataKit.xcodeproj'
  end
end