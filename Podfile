use_frameworks!

platform :ios, 10.0

workspace 'RandomUser.xcworkspace'

# Common dependencies versions
$rxSwiftVersion =                     '~> 4.2'

def shared_RandomUserDataKit_pods
  pod 'RxSwift',                        $rxSwiftVersion
  pod 'RealmSwift',                     '~> 3.10'
  pod 'RxRealm',                        '~> 0.7'
end

target 'RandomUser' do
  project 'RandomUser.xcodeproj'

  shared_RandomUserDataKit_pods

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
  
  shared_RandomUserDataKit_pods

  target 'RandomUserDataKitTests' do
    project 'RandomUserDataKit.xcodeproj'
  end
end