#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint virtru_sdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'virtru_sdk'
  s.version          = '0.0.1'
  s.summary          = 'Flutter wrapper for virtru-tdf3-cpp'
  s.description      = <<-DESC
Flutter wrapper for virtru-tdf3-cpp
                       DESC
  s.homepage         = 'http://virtru.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Virtru' => 'support@virtru.com' }
  s.source           = { :path => '.' }
  s.vendored_frameworks = "virtru_tdf3.xcframework"
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
