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