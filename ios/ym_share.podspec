#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'ym_share'
  s.version          = '1.0.1'
  s.summary          = 'Share content through the native platform share UI.'
  s.description      = <<-DESC
A Flutter plugin to share content from your Flutter app via the platform's share dialog.
Downloaded by pub (not CocoaPods).
                       DESC
  s.homepage         = 'https://github.com/yashmanghnani/ym_share'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Yash Manghnani' => 'yashmanghnani@gmail.com' }
  s.source           = { :path => '.' }
  s.documentation_url = 'https://pub.dev/packages/ym_share'
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '15.0'
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }
end
