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
  s.vendored_libraries = "libvirtru_tdf3.dylib"
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.14'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
