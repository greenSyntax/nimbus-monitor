#
# Be sure to run `pod lib lint nimbus-sdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NimbusMonitor'
  s.version          = '1.0.9'
  s.summary          = 'Monitor for iOS Application'

  s.homepage         = 'https://github.com/greenSyntax/nimbus-monitor'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AbhishekRavi' => 'ab.bhishek.ravi@gmail.com' }
  s.source           = { :git => 'https://github.com/greenSyntax/nimbus-monitor.git', :tag => s.version.to_s }
  s.swift_version = '5.0'
  s.ios.deployment_target = '12.0'
  s.resources = ['nimbus-sdk/Classes/Utils/*.{storyboard,xib,xcassets,json, png, pdf,xcdatamodeld}']
  s.source_files = 'nimbus-sdk/Classes/**/*.{swift, plist, storyboard, xib, xcassets, json, png, pdf, xcdatamodeld }'
end
