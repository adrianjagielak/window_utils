#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'window_utils'
  s.version          = '0.0.3'
  s.summary          = 'A flutter plugin for managing window decoration.'
  s.description      = <<-DESC
A flutter plugin for managing window decoration.
                       DESC
  s.homepage         = 'https://github.com/rive-app/window-utils'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Rive' => 'info@rive.app' }
  s.source           = { :path => '.' }
  s.source_files     = 'window_utils/Sources/window_utils/**/*.swift'
  s.dependency 'FlutterMacOS'

  s.platform = :osx
  s.osx.deployment_target = '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
