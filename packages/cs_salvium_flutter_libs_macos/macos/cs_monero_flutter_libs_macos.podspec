#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint cs_monero_flutter_libs_macos.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'cs_salvium_flutter_libs_macos'
  s.version          = '0.0.1'
  s.summary          = 'Binaries required to use cs_salvium in a Flutter project'
  s.description      = <<-DESC
Binaries required to use cs_salvium in a Flutter project
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.vendored_frameworks = 'Frameworks/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
